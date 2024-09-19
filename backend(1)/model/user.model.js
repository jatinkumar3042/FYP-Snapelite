const mongoose = require('mongoose');
const bcrypt =require("bcrypt");
const db = require('../config/db');

const {Schema} = mongoose;

const UserSchema = new Schema({
    name:{
        type:String,
        require:true
    },
    cnic:{
        type:String,
        require:true
    },
    number:{
        type:String,
        require:true,
        unique:true,
    },
    address:{
        type:String,
        require:true
    },
    age:{
        type:String,
        require:true
    },
    password:{
        type:String,
        require:true
    },
    cat:{
        type:String,
        require:true
    },
    deviceid:{
        type:String,
        require:true
    },
});
  UserSchema.pre('save',async function(){
  try {
        var user =this;
        const salt = await bcrypt.genSalt(10);
        const hashpass = await bcrypt.hash(user.password, salt);
        

        user.password =hashpass;
      } catch (error) {
        throw error;
        
      }

  });

  UserSchema.methods.comparePassword = async function(userpassword){
    try{
        const isMatch = await bcrypt.compare(userpassword,this.password);
        return isMatch;
    } catch(e){
        throw e;
    }
} 

const Usermodel = db.model('user',UserSchema); 
module.exports= Usermodel;
