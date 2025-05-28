const mongoose=require("mongoose");
const fineSchema=new mongoose.Schema({
    cycleId: String,
    rollNo:String,
    fine:{type:Number,default:0},
    date:{type:Date,default:Date.now}


});
module.exports=fineSchema;