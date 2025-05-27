const mongoose = require("mongoose");

const cycleSchema = new mongoose.Schema({
  cycleId: String,
  status: Boolean,
});

module.exports = cycleSchema; 
