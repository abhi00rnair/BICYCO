const express = require("express");
const { OAuth2Client } = require("google-auth-library");
const dotenv=require("dotenv");
const mongoose = require("mongoose");
const app = express();

const { studentConnection, cycleConnection,fineconnection } = require("./connection");
const studentSchema = require("./student");
const cycleSchema = require("./cycle");
const fineSchema=require("./fine");


require('dotenv').config({path:'./url.env'});
const CLIENT_ID=process.env.GOOGLE_CLIENT_ID;
const client=new OAuth2Client(CLIENT_ID);
app.use(express.json());

const Student = studentConnection.model("Student", studentSchema);
const Cycle = cycleConnection.model("Cycle", cycleSchema);
const Fine=fineconnection.model("fine",fineSchema,);

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
//api for fetching the profile details

app.get("/api/profile", verifyToken, async (req, res) => {
  try {
    const email=req.userEmail;
    const student = await Student.findOne({ emailId: email });
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
// api for fetching the fine
app.get("/api/fetchfine", async (req, res) => {
  const { rollNo } = req.query;
  if (!rollNo) {
    return res.status(400).json({ error: "rollNo is required" });
  }
  try {
    const fine = await Fine.findOne({ rollNo: rollNo });
    if (!fine) {
      return res.status(404).json({ message: "No fine found for this roll number" });
    }
    res.json(fine);
  } catch (error) {
    console.error("❌ Error fetching fine:", error);
    res.status(500).json({ error: "Server error" });
  }
});
// api for getting the cycle details of corresponding dept
app.get("/api/cycle", verifyToken, async (req, res) => {
  const email = req.userEmail;
  const dept = email.split("@")[0].slice(-2); 

  try {
    console.log("✅ Extracted department:", dept);
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
  try {
    const { cycleId } = req.body;

    if (!cycleId) {
      return res.status(400).json({ error: "cycleId is required" });
    }

    const dept = cycleId.slice(0, 2).toLowerCase();

    const DynamicCycleModel = cycleConnection.model(dept, cycleSchema, dept);

    const updatedCycle = await DynamicCycleModel.findOneAndUpdate(
      { cycleId: cycleId },
      { $set: { status: false } },
      { new: true }
    );

    if (!updatedCycle) {
      return res.status(404).json({ error: "Cycle not found" });
    }

    res.json({ message: "Cycle status updated", cycle: updatedCycle });
  } catch (error) {
    console.error("❌ Error updating cycle status:", error);
    res.status(500).json({ error: "Server error" });
  }
});

app.post("/api/bookfine", async(req,res)=>{
  try{
    const{cycleId,rollNo}=req.body;
    if(!cycleId || !rollNo){
      return res.status(400).json({error:"cycle id and roll no req"});
    }
    const fine=new Fine({cycleId,rollNo});
    const savedFine=await fine.save();
  res.status(200).json({ message: "Fine initialized", fine: savedFine });
  } catch (error) {
    console.error("❌ Error booking fine:", error);
    res.status(500).json({ error: "Server error" });
  }
}
);



app.listen(2000, () => {
  console.log("Server running on port 2000");
});
