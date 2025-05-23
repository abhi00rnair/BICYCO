const mongoose = require('mongoose');

const studentSchema = new mongoose.Schema({
  name: {
    type: String,required: true,
  },
  rollNo: {
    type: String,
    required: true,

  },
  emailId: {
    type: String,
    required: true,   
  }
});

const Student = mongoose.model('Student', studentSchema,'studentlist');

module.exports = Student;
