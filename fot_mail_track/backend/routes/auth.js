// const express = require('express');
// const bcrypt = require('bcryptjs');
// const jwt = require('jsonwebtoken');
// const User = require('../models/user'); // Adjust the path based on your file structure

// const router = express.Router();

// // Load environment variables
// require('dotenv').config();

// // Login route
// router.post('/login', async (req, res) => {
//   const { email, password } = req.body;

//   console.log('Request body:', req.body); 
//   console.log("Login request received with email:", email, "and password:", password);
//   // Log model and collection details
//   console.log('Mongoose model name:', User.modelName);
//   console.log('Collection name:', User.collection.collectionName);


//   try {
//     // Check if the user exists
//     const user = await User.findOne({email});
//     console.log("User found:", user);
//     if (!user) return res.status(400).json({ message: 'Invalid email' });

//     // Compare passwords
//     const isMatch = await bcrypt.compare(password, user.password);
//     if (!isMatch) return res.status(400).json({ message: 'Invalid password' });

//     // Generate JWT
//     const token = jwt.sign({ id: user._id, role: user.role }, { expiresIn: '10h' });

//     // Send response
//     res.json({ token, user: { id: user._id, email: user.email, role: user.role } });
//   } catch (err) {
//     console.error(err);
//     res.status(500).json({ message: 'Server error' });
//   }
// });


// module.exports = router;


//New Code 

const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/user'); // Adjust the path based on your file structure

const router = express.Router();

// Load environment variables
require('dotenv').config();

// Registration route
router.post('/register', async (req, res) => {
  const { email, password, role } = req.body;

  console.log('Request body:', req.body);
  console.log("Registration request received with email:", email);

  try {
    // Check if the user already exists
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ message: 'Email already in use' });
    }

    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);

     // Create a new user
    const newUser = new User({
      email,
      password: hashedPassword,
      role: role || 'user' // Default role if not provided
    });

    // Save the user to the database
    await newUser.save();

    // Generate JWT
    const token = jwt.sign({ id: newUser._id, role: newUser.role }, process.env.JWT_SECRET, { expiresIn: '10h' });

    // Send response
    res.status(201).json({ token, user: { id: newUser._id, email: newUser.email, role: newUser.role } });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
});

// Login route
router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  console.log('Request body:', req.body);
  console.log("Login request received with email:", email);

  try {
    // Check if the user exists
    const user = await User.findOne({ email });
    if (!user) return res.status(400).json({ message: 'Invalid email' });

    // Compare passwords
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(400).json({ message: 'Invalid password' });

    // Generate JWT
    const token = jwt.sign({ id: user._id, role: user.role }, process.env.JWT_SECRET, { expiresIn: '10h' });

    // Send response
    res.json({ token, user: { id: user._id, email: user.email, role: user.role } });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
});

module.exports = router;