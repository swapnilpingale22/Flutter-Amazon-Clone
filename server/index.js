const express = require("express");
const mongoose = require("mongoose");

//import from other files
const authRouter = require("./routes/auth");

//init
const PORT = 3000;
const app = express();
const Url = "mongodb+srv://swapnil:Swapnil123@cluster0.dtqtzbq.mongodb.net/?retryWrites=true&w=majority"
const localUrl = "mongodb://127.0.0.1:27017/Amazon_Clone_Db"

//middleware
app.use(express.json());
app.use(authRouter);

//connections
mongoose.connect(localUrl)
    .then(() => {
        console.log('Connected to MongoDB');
    })
    .catch((error) => {
        console.error('Error connecting to MongoDB:', error);
    });

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Server  is running on http://localhost:${PORT}/user`);
});