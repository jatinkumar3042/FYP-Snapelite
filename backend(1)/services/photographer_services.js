
const photographerModel = require('../model/photographer_model');
class photographerService {
    static async registerphotographer(userId,img,email,bio,exp,Work,socialmedia){
        try {
            const photographercreate =new photographerModel({userId,img,email,bio,exp,Work,socialmedia});
            return await photographercreate.save();
        } catch (error) {
            console.log(error)
            
        }

    }

    static async getone(userId){
        try{
            return await photographerModel.findOne({userId});
        } catch(e){
            console.log(e)
                res.json({status:false,sucess:"server error service chcekuser"});
        }
       }

       static async getall(){
        try{
            return await photographerModel.find();
        } catch(e){
            console.log(e)
                res.json({status:false,sucess:"server error service chcekuser"});
        }
       }
    
       static async updatephotoservice(userId,img,email,bio,exp,Work,socialmedia){ 
        try {
            await photographerModel.findOneAndUpdate({userId},
                {img:img,email:email,bio:bio,exp:exp,Work:Work,socialmedia:socialmedia});
        } catch (error) {
             console.log(error);   
        }
    }

    static async updatephoto(userId,img){ 
        try {
            await photographerModel.findOneAndUpdate({userId:userId},{img:img});
        } catch (error) {
             console.log(error);   
        }
    }

}

module.exports = photographerService;