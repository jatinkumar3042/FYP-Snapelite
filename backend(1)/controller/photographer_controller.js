const photoservice = require('../services/photographer_services');
const ratings = require('../model/rating.modal');

exports.registerphotographer = async(request,response,next)=>{
    try {
        const {userId,img,email,bio,exp,Work,socialmedia} = request.body;
        const d = await photoservice.getone(userId);
        if(d){
            await photoservice.updatephotoservice(userId,img,email,bio,exp,Work,socialmedia);
            response.json({status:true,sucess:"service updated Sucessfully" });
        } else {
            await photoservice.registerphotographer(userId,img,email,bio,exp,Work,socialmedia);
            response.json({status:true,sucess:"service registered Sucessfully" });
        }
    } catch (error) {
         console.log(error)
         response.json({status:false,sucess:"server error controller register"});
    }    
}

exports.getone =async (request,response,next)=>{
       
    try {
     const {userId}=request.body;
     const d = await photoservice.getone(userId);
     response.json({status:true,sucess:"service registered Sucessfully" ,data:d});
       } catch (error) {
          console.log(error)
          response.json({status:false,sucess:"server error controller register"})
       } 
 }


 exports.updatephoto =async (request,response,next)=>{
    try {
     const {userId,img}=request.body;
     await photoservice.updatephoto(userId,img);
     response.json({status:true});
       } catch (error) {
          console.log(error)
          response.json({status:false})
       } 
 }


//  exports.getall =async (request,response,next)=>{
//     try {
//      const d = await photoservice.getall();
//      console.log(d)

//      response.json({status:true,data:d});
//        } catch (error) {
//           console.log(error)
//           response.json({status:false})
//        } 
//  }

exports.getall = async (request, response, next) => {
    try {
        const photos = await photoservice.getall();

        const photosWithRatings = await Promise.all(photos.map(async (photo) => {
            const userRatings = await ratings.find({ did: photo.userId });
            const photoObject = photo.toObject(); // Convert Mongoose document to plain object
            return {
                ...photoObject,
                ratingCount: userRatings.length
            };
        }));

        photosWithRatings.sort((a, b) => b.ratingCount - a.ratingCount);

        response.json({status:true, data: photosWithRatings});
    } catch (error) {
        console.log(error);
        response.json({ status: false });
    }
};