const express = require("express");
const { OAuth2Client } = require("google-auth-library");
const mongoose = require("mongoose");
require('dotenv').config({path:'./url.env'});

const app = express();

const MONGOURIGET=process.env.MONGO_URI_GET;
const CLIENT_ID=process.env.GOOGLE_CLIENT_ID;

const client=new OAuth2Client(CLIENT_ID);
app.use(express.json());


const Student=require('./student');


async function connectToDB() {
  try {
    await mongoose.connect(MONGOURIGET, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log("Connected to MongoDB using Mongoose");
  } catch (error) {
    console.error(" Failed to connect to MongoDB:", error);
  }
}

connectToDB();
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
    console.log("📩 Verified user email:", req.userEmail);

    // Print email before querying database
    console.log("🔍 Querying Student collection with emailId:", req.userEmail);

    const student = await Student.findOne({ emailId: req.userEmail }); 

    if (!student) {
      console.log("❌ Student not found in DB for:", req.userEmail);
      return res.status(404).json({ error: "Student not found" });
    }

    console.log("✅ Student found:", student);
    res.json(student);
  } catch (error) {
    console.error("🔥 Error fetching student:", error);  
    res.status(500).json({ error: "Server error" });
  }
});


app.listen(2000, () => {
  console.log("Server running on port 2000");
});
