const Usermodel = require('../model/user.model');
const jwt =require('jsonwebtoken');

class Userservice{

    static async registerUser(name,cnic,number,address,age,password,cat,deviceid){
        try{
          const creatuser =new Usermodel({name,cnic,number,address,age,password,cat,deviceid});
          return await creatuser.save();
        }catch(error){
            console.log(error)
            res.json({status:false,sucess:"server error service register"});
             
        }

    }
    
    static async updatedevice(userId,deviceid){
        try{
            await Usermodel.findByIdAndUpdate(userId, { $set: { deviceid: deviceid } });
        } catch(e){
            console.log(e)
                res.json({status:false,sucess:"server error service chcekuser"});
        }
       }

    static async finduser(id){
        try{
            return await Usermodel.findById(id);
        } catch(e){
            console.log(e)
                res.json({status:false,sucess:"server error service chcekuser"});
        }
       }

static async checkuser(number){
    try{
        return await Usermodel.findOne({number});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }
   static async generateToken(tokenData,secretKey,jwt_expiry){
    return jwt.sign(tokenData,secretKey,{expiresIn:jwt_expiry});
   }
} 
module.exports = Userservice;