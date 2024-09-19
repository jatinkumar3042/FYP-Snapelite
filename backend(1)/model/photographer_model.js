const mongoose = require('mongoose');
const db = require('../config/db');
const user =require('../model/user.model')


const { Schema } =mongoose;

const photographerschema = new Schema({
    
userId:{
    type: String,
    },
img:{
   type:String 
},
email:{
    type:String
},
bio:{
    type:String
},
exp:{
    type:String
},
Work:{
    type:String
},
socialmedia:{
    type:String,
},
});

const photographermodel =db.model('photographers',photographerschema);
module.exports = photographermodel;