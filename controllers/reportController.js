exports.addReport = async (req, res) => {
  const { location, mediaUrl } = req.body;

  if (!location.lat || !location.lng) {
    return res.status(400).send("Invalid location");
  }

  // Check for duplicate before adding
  const checkDuplicate = await db
    .collection("reports")
    .where("mediaUrl", "==", mediaUrl)
    .get();

  if (!checkDuplicate.empty) {
    return res.status(409).send("Duplicate Report");
  }

  const report = {
    userId: req.user.uid,
    status: "Pending",
    location,
    mediaUrl,
    created_at: new Date()
  };

  await db.collection("reports").add(report);
  res.send("Report Submitted");
};
