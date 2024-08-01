const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const validator = require('validator');


const UserSchema = new mongoose.Schema({
 
    email:{
        type: String,
        required: true,
        unique: true,
        trim: true,
        
    },
    password: {
        type: String,
        required: true,
    },
   
});
const User = mongoose.model("User", UserSchema);
console.log("User is : ",  User.email);
console.log("User model created with schema:", User.schema.obj);

module.exports = User;

