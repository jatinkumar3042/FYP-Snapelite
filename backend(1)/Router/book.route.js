const book = require('../model/bookmodel');
const app = require('express').Router();

app.post('/registerbook', async (req, res, next) => {
    try {
      const { uid, bid, sid, date, status,lat, lon } = req.body;
      const newbook = new book({ uid, bid, sid, date, status,lat, lon });
      await newbook.save();
      res.status(200).json({ status: true});
    } catch (error) {
      console.error(error);
      res.status(500).json({ status: false });
    }
});

app.post('/allbookbyuid', async (req, res, next) => {
    try {
        const {uid} = req.body;
      const user = await book.find({uid:uid});
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});

app.post('/allbookbybid', async (req, res, next) => {
  try {
      const {bid} = req.body;
    const user = await book.find({bid:bid});
    res.status(200).json({ status:true ,data:user});
  } catch (error) {
    console.log(error);
    res.status(500).json({ status:false,data:[] });
  }
});

app.post('/changestatus', async (req, res, next) => {
  try {
      const {id,status} = req.body;
    await book.findByIdAndUpdate(id,{status:status});
    res.status(200).json({ status:true});
  } catch (error) {
    console.log(error);
    res.status(500).json({ status:false });
  }
});
module.exports = app;
