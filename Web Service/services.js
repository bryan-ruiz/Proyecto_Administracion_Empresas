//Initiallising node modules
var express = require("express");
var bodyParser = require("body-parser");
var sql = require("mssql");
var app = express(); 

// Body Parser Middleware
app.use(bodyParser.json()); 

//CORS Middleware
app.use(function (req, res, next) {
    //Enabling CORS 
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Methods", "GET,HEAD,OPTIONS,POST,PUT");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, contentType,Content-Type, Accept, Authorization");
    next();
});


//Setting up server
var server = app.listen(process.env.PORT || 8080, function () {
    var port = server.address().port;
    console.log("App now running on port", port);
 });

//Initiallising connection string
var dbConfig = {
    user:  "sa",
    password: "12345",
    server: "localhost",
    database: "AcreditacionTEC"
};

//Function to connect to database and execute query
var  executeQuery = function(res, query){             
    sql.connect(dbConfig, function (err) {
        if (err) {   
            console.log("Error while connecting database :- " + err);
            res.send(err);
        }
        else {
            // create Request object
            var request = new sql.Request();
            // query to the database

            //request.execute('procedure_name', (err, result) => {

            //}
            /*
            request.query(query, function (err, res) {
                if (err) {
                    console.log("Error while querying database :- " + err);
                    res.send(err);
                }
                else {
                    console.log(res);
                    res.recordsets = res;
                }                
            });*/
        }
     });           
}

//GET API
app.get("/selectComponentes", function(req , res){
    var query = "SELECT * FROM Componentes;";
    var request = new sql.Request(dbConfig);
    // query to the database

    request.execute('SELECT * FROM Componentes', (err, result) => {
        console.log(err);
    })
    //executeQuery (res, query);
});