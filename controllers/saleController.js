exports.buyReport = async (req, res) => {
  const { reportId, price } = req.body;

  const profit = price * 0.7;

  await db.collection("sales").add({
    reportId,
    buyerId: req.user.uid,
    price,
    profit,
    sale_date: new Date()
  });

  res.send("Purchase Successful");

  
await db.collection("users")
  .doc(userId)
  .update({
    reputation_score: admin.firestore.FieldValue.increment(10)
  });

};
