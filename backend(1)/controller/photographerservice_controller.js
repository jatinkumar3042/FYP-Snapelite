const photoservies= require('../services/photogrpherService_service');

exports.registerphotoservice =async (request,response,next)=>{
    try {
     const {userId,img,name,des,price,availability,duration}=request.body;
     await photoservies.registerphotoservice(userId,img,name,des,price,availability,duration);
     response.json({status:true,sucess:"service registered Sucessfully" });
       } catch (error) {
          console.log(error)
          response.json({status:false,sucess:"server error controller register"})
       } 
}


exports.getbyid =async (request,response,next)=>{
   try {
    const {userId}=request.body;
    const u = await photoservies.getbyid(userId);
    response.json({status:true,sucess:"service registered Sucessfully" ,data:u});
      } catch (error) {
         console.log(error)
         response.json({status:false,sucess:"server error controller register"})
      } 
}

exports.getallservices =async (request,response,next)=>{
   try {
    const u = await photoservies.getallservices();
    response.json({status:true,sucess:"service registered Sucessfully" ,data:u});
      } catch (error) {
         console.log(error)
         response.json({status:false,sucess:"server error controller register"})
      } 
}

exports.getbyuidservices =async (request,response,next)=>{
   try {
      const {userId}=request.body;
    const u = await photoservies.getbyuidservices(userId);
    response.json({status:true,sucess:"service registered Sucessfully" ,data:u});
      } catch (error) {
         console.log(error)
         response.json({status:false,sucess:"server error controller register"})
      } 
}


exports.getoneservices =async (request,response,next)=>{
   try {
      const {id}=request.body;
    const u = await photoservies.getoneservices(id);
    response.json({status:true,sucess:"service registered Sucessfully" ,data:u});
      } catch (error) {
         console.log(error)
         response.json({status:false,sucess:"server error controller register"})
      } 
}

exports.deleteservices =async (request,response,next)=>{
   try {
      const {id}=request.body;
    const u = await photoservies.deleteservices(id);
    response.json({status:true});
      } catch (error) {
         console.log(error)
         response.json({status:false})
      } 
}

exports.updateservice =async (request,response,next)=>{
   try {
      const {id,name,des,price,duration}=request.body;
    const u = await photoservies.updateservice(id,name,des,price,duration);
    response.json({status:true});
      } catch (error) {
         console.log(error)
         response.json({status:false})
      } 
}