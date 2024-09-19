const workArticles = require('../model/work_model');
const app = require('express').Router();

app.post('/registerwork', async (req, res, next) => {
    try {
      const { uid, img, name } = req.body;
      const user = new workArticles({uid, img, name});
      await user.save();
      res.status(200).json({ status:true ,message:"register sucessfully"});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,message:"try again later" });
    }
});

app.post('/workbyid', async (req, res, next) => {
    try {
      const { uid } = req.body;
      const user = await workArticles.find({uid});
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});

module.exports = app;