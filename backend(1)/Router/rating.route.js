const ratings = require('../model/rating.modal');
const app = require('express').Router();

app.post('/registerrating', async (req, res, next) => {
    try {
      const { uid, did, rating, review } = req.body;
        const newChat = new ratings({uid, did, rating, review});
        await newChat.save();
        res.status(200).json({ status: true});
    } catch (error) {
      console.error(error);
      res.status(500).json({ status: false});
    }
});

app.post('/allratingbydid', async (req, res, next) => {
  try {
    const { did } = req.body;
    const user = await ratings.find({ did: did });
    res.status(200).json({ status: true, data: user });
  } catch (error) {
    console.log(error);
    res.status(500).json({ status: false, data: [] });
  }
});


module.exports = app;