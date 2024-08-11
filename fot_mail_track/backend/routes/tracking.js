// const jwt = require('jsonwebtoken');
// const Letter = require('../models/letters');
// const express = require('express');

// const router = express.Router();
// // Load environment variables
// require('dotenv').config();
// // letter tracking route
// router.post('/tracking', async (req, res) => {
//   const { title } = req.body; 

//     try {
//     // Check if the letter exists
//     const letter = await Letter.findOne({ title });
//     if (!letter) return res.status(400).json({ message: 'Invalid Letter' });

    

//     // Generate JWT
//     const token = jwt.sign({ id: letter._id, title: letter.title }, process.env.JWT_SECRET, { expiresIn: '1h' });

//     // Send response
//     res.json({ token, letter: { id: letter._id, title: letter.title } });
//   } catch (err) {
//     console.error(err);
//     res.status(500).json({ message: 'Server error' });
//   }

// })

// module.exports =router;