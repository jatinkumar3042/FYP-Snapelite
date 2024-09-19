const mongoose = require('mongoose');
const db = require('../config/db');
const user =require('../model/user.model')
const { Schema } = mongoose;

const photoserviceSchema = new Schema({
userId:{
        type: Schema.Types.ObjectId,
        ref:user.modelName
},
img:{
   type:String,
},
name:{
    type:String,
},
des:{
    type:String ,
},
price:{
    type:String ,
},
availability:{
    type:String, 
},
duration:{
   type:String, 
},
});

const photoserviceModel = db.model('photoservice',photoserviceSchema);
module.exports = photoserviceModel;