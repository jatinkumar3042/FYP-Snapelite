const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const ratingSchema = new Schema({
    uid:{
        type:String,
    },
    did:{
        type:String,
    },
    rating:{
        type:String,
    },
    review:{
        type:String,
    },
});

const ratingModel = db.model('rating',ratingSchema);
module.exports = ratingModel;