const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/user'); // Adjust the path based on your file structure
const Letter = require('../models/letters');

const router = express.Router();

// Load environment variables
require('dotenv').config();





// Login route
router.post('/login', async (req, res) => {
  const { email, password } = req.body;

   console.log('Request body:', req.body);
   
  // console.log("Login request received with email:", email);

  try {
    // Check if the user exists
    const user = await User.findOne({ email });
    if (!user) return res.status(400).json({ message: 'Invalid email' });

    // Compare passwords
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(400).json({ message: 'Invalid password' });

    // Generate JWT
    const token = jwt.sign({ id: user._id, role: user.role , registrationNumber: user.registrationNumber ,  username:user.username , faculty:user.faculty, name: user.name , department:user.department }, process.env.JWT_SECRET, { expiresIn: '1h' });

    console.log(' User Name is ' + user.name);
    console.log(' ID is ' + user._id);
    console.log('User email:', user.email);
    // Send response
    res.json({ token, user: { id: user._id, email: user.email,
    name: user.name ,  role: user.role , registrationNumber: user.registrationNumber ,  username:user.username , faculty:user.faculty , department:user.department } });
    
  } catch (err) {
    console.error( "Error is " + err);
    res.status(500).json({ message: 'Server error' });
  }
});

//Create Tracking routers


router.post('/tracking', async (req, res) => {
  const { registrationNumber } = req.body;

  try {
    const letters = await Letter.find({
      $or: [
        { 'sender.registrationNumber': registrationNumber },
        { 'receiver.registrationNumber': registrationNumber },
        
      ]
    });

    if (letters.length === 0) return res.status(400).json({ message: 'Invalid Letter' });

    
    res.json(letters); 
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error on tracking route' });
  }
});

//Create Letter Status Update routes

router.patch('/statusUpdate', async (req, res) => {
  const { _id, currentHolder, status, holderId } = req.body;

  try {
    const letter = await Letter.findOne({ _id });

    if (!letter) return res.status(400).json({ message: 'Invalid Letter' });

    const trackingLogEntry = {
      holder: holderId,
      status: status,
      date: new Date()
    };

    console.log(trackingLogEntry);

    const updates = {
      $set: { currentHolder: currentHolder },
      $push: { trackingLog: trackingLogEntry } // Add new object to trackingLog
    };
    const query = { _id: letter._id };
    let result = await Letter.updateOne(query, updates);

    const token = jwt.sign({ id: letter._id, title: letter.title, sender: letter.sender }, process.env.JWT_SECRET, { expiresIn: '1h' });

    res.json({ token, letter: { id: letter._id, title: letter.title, sender: letter.sender } });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error on statusUpdate route' });
  }
});

//TrackingLog Update Path
router.put('/updateTracking/:uniqueID', async (req, res) => {
  const uniqueID = req.params.uniqueID;
  console.log(`Unique ID is : ${uniqueID}`);
  const { user } = req.body; // User object should contain the user details to be added to the trackingLog

  try {
    // Find the letter by uniqueID
    const letter = await Letter.findOne({ uniqueID });
    console.log(`Unique ID is in here : ${uniqueID}`);
    if (!letter) return res.status(404).json({ message: 'Letter not found' });

    // Update trackingLog by pushing the new user to the array
    letter.trackingLog.push({
      user: user._id,
      name: user.name,
      uniqueID:user.uId,
      updatedAt: new Date()
    });

    // Update the currentHolder field with the new user
    letter.currentHolder = user._id;  // Assuming user._id is the identifier of the user

    // Save the updated letter
    await letter.save();

    res.json({ message: 'Tracking log updated', letter });
  } catch (error) {
    console.error('Error updating tracking log:', error);
    res.status(500).json({ message: 'Server error' });
  }
});





module.exports = router;