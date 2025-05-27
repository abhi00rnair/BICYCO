const express = require("express");
const { OAuth2Client } = require("google-auth-library");
const dotenv=require("dotenv");
const { studentConnection, cycleConnection } = require("./connection");
const studentSchema = require("./student");
const cycleSchema = require("./cycle");


const mongoose = require("mongoose");
require('dotenv').config({path:'./url.env'});

const app = express();

const MONGOURIGET=process.env.MONGO_URI_GET;
const CLIENT_ID=process.env.GOOGLE_CLIENT_ID;

const client=new OAuth2Client(CLIENT_ID);
app.use(express.json());

const Student = studentConnection.model("Student", studentSchema);
const Cycle = cycleConnection.model("Cycle", cycleSchema);


async function verifyToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ error: 'Missing or invalid Authorization header' });
  }

  const idToken = authHeader.split(' ')[1];

  try {
    const ticket = await client.verifyIdToken({
      idToken: idToken,
      audience: CLIENT_ID,
    });

    const payload = ticket.getPayload();
    req.userEmail = payload.email;
    next();
  } catch (error) {
    console.error("Token verification failed:", error);
    return res.status(403).json({ error: "Invalid or expired token" });
  }
}
app.get("/api/profile", verifyToken, async (req, res) => {
  try {
    console.log("Student connection readyState:", studentConnection.readyState);
    console.log("Connected DB name:", studentConnection.name);

    const collections = await studentConnection.db.listCollections().toArray();
    console.log("Collections in DB:", collections.map(c => c.name));

    const email = req.userEmail.trim().toLowerCase();
    console.log("📩 Verified user email:", email);

    // Raw query for debug (without model)
    const rawStudents = await studentConnection.db.collection('studentlist').find({ emailId: email }).toArray();
    console.log("Raw students found:", rawStudents);

    // Model query
    const student = await Student.findOne({ emailId: email });
    console.log("Model query result:", student);

    if (!student) {
      console.log("❌ Student not found in DB for:", email);
      return res.status(404).json({ error: "Student not found" });
    }

    res.json(student);
  } catch (error) {
    console.error("🔥 Error fetching student:", error);
    res.status(500).json({ error: "Server error" });
  }
});
app.get("/api/cycle", verifyToken, async (req, res) => {
  const email = req.userEmail;
  const dept = email.split("@")[0].slice(-2); 

  try {
    console.log("✅ Extracted department:", dept);

    // Dynamically create a model for the department-specific collection
    const DynamicCycleModel = cycleConnection.model(dept, require('./cycle'), dept);
    console.log("📦 Using collection:", DynamicCycleModel.collection.collectionName);

    const cycles = await DynamicCycleModel.find({});
    console.log(`📋 Found ${cycles.length} cycles in ${dept} collection`);

    res.json(cycles);
  } catch (err) {
    console.error("❌ Error fetching cycles:", err);
    res.status(500).json({ error: "Error fetching cycles" });
  }
}
);
app.patch("/api/cyclebook", async (req, res) => {
  const { cycleId } = req.body;

  if (!cycleId) {
    return res.status(400).json({ error: "cycleId is required" });
  }

  const dept = cycleId.substring(0, 2); // Extract dept from cycleId like "cs"

  try {
    // Dynamically use correct collection based on department
    const DynamicCycleModel = cycleConnection.model(dept, cycleSchema, dept);

    const updatedCycle = await DynamicCycleModel.findOneAndUpdate(
      { cycleId: cycleId },
      { $set: { status: false } },
      { new: true }
    );

    if (!updatedCycle) {
      return res.status(404).json({ error: "Cycle not found" });
    }

    res.status(200).json({ message: "Cycle status updated to false", cycle: updatedCycle });
  } catch (err) {
    console.error("❌ Error updating cycle status:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});




app.listen(2000, () => {
  console.log("Server running on port 2000");
});
