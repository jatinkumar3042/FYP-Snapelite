const photoserviceModel = require('../model/photographerServiece_model');

class photoservice {
    static async registerphotoservice(userId,img,name,des,price,availability,duration){ 
    try {
        const photoserviceorder = new photoserviceModel({userId,img,name,des,price,availability,duration});
        return await photoserviceorder.save();
    } catch (error) {
         console.log(error);   
    }
}

static async getbyid(userId){ 
    try {
        return await photoserviceModel.find({userId});
    } catch (error) {
         console.log(error);   
    }
}

static async getallservices(){ 
    try {
        return await photoserviceModel.find();
    } catch (error) {
         console.log(error);   
    }
}

static async getbyuidservices(userId){ 
    try {
        return await photoserviceModel.find({userId});
    } catch (error) {
         console.log(error);   
    }
}

static async getoneservices(id){ 
    try {
        return await photoserviceModel.findById(id);
    } catch (error) {
         console.log(error);   
    }
}

static async deleteservices(id){ 
    try {
        return await photoserviceModel.findByIdAndDelete(id);
    } catch (error) {
         console.log(error);   
    }
}

static async updateservice(id,name,des,price,duration){ 
    try {
        return await photoserviceModel.findByIdAndUpdate(id,{$set:{name:name,des:des,price:price,duration:duration}});
    } catch (error) {
         console.log(error);   
    }
}

}
module.exports = photoservice;