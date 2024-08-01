const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/user'); // Adjust the path based on your file structure

const router = express.Router();

// Load environment variables
require('dotenv').config();

// Login route
router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  console.log('Request body:', req.body); 
  console.log("Login request received with email:", email, "and password:", password);
  // Log model and collection details
  console.log('Mongoose model name:', User.modelName);
  console.log('Collection name:', User.collection.collectionName);


  try {
    // Check if the user exists
    const user = await User.findOne({ email });
    console.log("User found:", user);
    if (!user) return res.status(400).json({ message: 'Invalid email' });

    // Compare passwords
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(400).json({ message: 'Invalid password' });

    // Generate JWT
    const token = jwt.sign({ id: user._id, role: user.role }, { expiresIn: '10h' });

    // Send response
    res.json({ token, user: { id: user._id, email: user.email, role: user.role } });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
});


module.exports = router;
