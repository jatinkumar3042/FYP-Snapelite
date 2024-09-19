const Userservice = require('../services/user.services');

exports.register = async(req,res,next)=>{
    try {
        const {name,cnic,number,address,age,password,cat,deviceid}=req.body;
        const successRes = await Userservice.registerUser(name,cnic,number,address,age,password,cat,deviceid);
        res.json({status:true,success:"User Sucessfully Registred",data:successRes});

    } catch (error) {
        throw(error)
    }

}

exports.login = async(req,res,next)=>{
    try {
     const {number,password,deviceid}=req.body;
      const user=await Userservice.checkuser(number);

      if(!user){
        throw new error ('User do not exit');
      }
      const isMatch =await user.comparePassword(password);
     if(isMatch == false){

        throw new Error('Password invlid ');
     }
     await Userservice.updatedevice(user._id, deviceid);
     let tokenData ={_id:user._id,number:user.number,name:user.name,cnic:user.cnic,address:user.address,age:user.age,password:user.password,cat:user.cat};
     
     const token =await Userservice.generateToken(tokenData,"secretKey","1h")

      res.status(200).json({status:true,token:token})
    } catch (error) {
      console.log(error)
       res.json({status:false,sucess:"server error controller register"});        
    }
 }


 exports.getonuser = async(req,res,next)=>{
  try{
      const {id} = req.body;
      const rest = await Userservice.finduser(id);
      if(!rest){
          res.status(200).json({status:false,message:"no order found"});
      } else{
          res.status(200).json({status:true,user:rest,message:"order founded"});
      }
  } catch (e){
      console.log(e)
      res.json({status:false,sucess:"server error controller login"});
  }
}