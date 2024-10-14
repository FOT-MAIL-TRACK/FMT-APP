const mongoose = require('mongoose');

const LetterSchema = new mongoose.Schema({
 
    title:{
        type: String,
        trim: true,
        
    },
    uniqueID:{
        type: String,
        required: true,
        trim: true,
        
    },
    content: {
        type: String,
 
    },
    sender: {
    type: Object,
    sparse: true, // Allows multiple documents without a username
    default: null // Ensure it defaults to null
  },
    receiver: {
    type: Object,
    sparse: true, // Allows multiple documents without a username
    default: null // Ensure it defaults to null
  },
  authorities: {
    type: Array,
    sparse: true, // Allows multiple documents without a username
    default: null // Ensure it defaults to null
  },
  currentHolder: {
    type: Object,
    default: null // Ensure it defaults to null
  },
  qrCode: {
    type: String,
    default: null // Ensure it defaults to null
  },
  trackingLog: {
    type: Array,
    default: null // Ensure it defaults to null
  },
  
  
});

const Letter = mongoose.model("Letter", LetterSchema);

module.exports = Letter;