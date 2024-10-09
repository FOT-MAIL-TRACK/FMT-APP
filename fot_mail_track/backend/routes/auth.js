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
    const token = jwt.sign({ id: user._id, role: user.role }, process.env.JWT_SECRET, { expiresIn: '1h' });

    // Send response
    res.json({ token, user: { id: user._id, email: user.email, role: user.role } });
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
        { 'receiver.registrationNumber': registrationNumber }
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




module.exports = router;