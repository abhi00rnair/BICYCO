const mongoose = require("mongoose");
require("dotenv").config({ path: "./url.env" });
const MONGO_URI_PROFILE = process.env.MONGO_URI_PROFILE;
const MONGO_URI_CYCLE = process.env.MONGO_URI_CYCLE;
const MONGO_URI_FINE=process.env.MONGO_URI_FINE;

const studentConnection = mongoose.createConnection(MONGO_URI_PROFILE, {
  useNewUrlParser: true,
  useUnifiedTopology: true
});

const cycleConnection = mongoose.createConnection(MONGO_URI_CYCLE, {
  useNewUrlParser: true,
  useUnifiedTopology: true
});
const fineconnection=mongoose.createConnection(MONGO_URI_FINE,{
  useNewUrlParser:true,
  useUnifiedTopology:true,
});

module.exports = {
  studentConnection,
  cycleConnection,fineconnection,
};
