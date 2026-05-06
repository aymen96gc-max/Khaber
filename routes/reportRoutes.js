const express = require("express");
const router = express.Router();

const verifyToken = require("../authMiddleware");
const {
  addReport
} = require("../controllers/reportController");

// Submit new report
router.post("/add", verifyToken, addReport);

module.exports = router;
