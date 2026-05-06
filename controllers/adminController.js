exports.updateStatus = async (req, res) => {
  const { reportId, status } = req.body;

  await db.collection("reports").doc(reportId).update({
    status,
    decision_time: new Date()
  });

  res.send("Status Updated");
};
