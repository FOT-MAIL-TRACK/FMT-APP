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
    username: {
    type: String,
    unique: true,
    sparse: true, // Allows multiple documents without a username
    default: null // Ensure it defaults to null
  },
    name: {
    type: String,
    sparse: true, // Allows multiple documents without a username
    default: null // Ensure it defaults to null
  },
  faculty: {
    type: String,
    sparse: true, // Allows multiple documents without a username
    default: null // Ensure it defaults to null
  },
  department: {
    type: String,
    sparse: true, // Allows multiple documents without a username
    default: null // Ensure it defaults to null
  },
  registrationNumber: {
    type: String,
    default: null // Ensure it defaults to null
  },
  

   
});
   const User = mongoose.model("User", UserSchema);
// console.log("User is : ",  User.email);
// console.log("User model created with schema:", User.schema.obj);

module.exports = User;

