const mongoose = require("mongoose");

const studentSchema = new mongoose.Schema({
  name: String,
  emailId: String,
  rollNo: String,
}, { collection: 'studentlist', });

module.exports = studentSchema; 
