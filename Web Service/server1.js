var express = require('express'); // Web Framework
var app = express();
var sql = require('mssql'); // MS Sql Server client

// Connection string parameters.
var sqlConfig = {
    user: 'sa',
    password: '12345',
    server: 'localhost',
    database: 'AcreditacionTEC'
}

// Start server and listen on http://localhost:8080/
var server = app.listen(8080, function () {
    var host = server.address().address
    var port = server.address().port

    console.log("app listening at http://%s:%s", host, port)
});

app.get('/getComponentes', function (req, res) {
    sql.connect(sqlConfig, function() {
        var request = new sql.Request();
        request.query('select * from Componentes', function(err, recordset) {
            if(err) console.log(err);
            res.end(JSON.stringify(recordset.recordsets[0])); // Result in JSON format but into a Array
        });
    });
})

app.get('/getDimensiones', function (req, res) {
    sql.connect(sqlConfig, function() {
        var request = new sql.Request();
        request.query('select * from Dimensiones', function(err, recordset) {
            if(err) 
                console.log(err);
            if (recordset.recordsets.length == 0)
                res.end(JSON.stringify(null));            
            else
                res.end(JSON.stringify(recordset.recordsets[0])); // Result in JSON format but into a Array            
            sql.close();
        });
    });
})

app.post('/setDimension', function (req, res) {

    var request = new Request('insertDimension', function(err) {
        if (err) {
            callback({
                success: false,
                data: err,
                error: request.error,
                title: "Error",
                message: "Sucedio un error en la modificación de los datos",
                type: "error"
            })
        }
    });

    request.addParameter('Dimension', TYPES.Int, datos.Dimension);

    sqlConection.callProcedure(request, callback);


/*
    sql.connect(sqlConfig, function() {
        var request = new sql.Request();
        request.query('INSERT INTO Dimensiones ()', function(err, recordset) {
            if(err) 
                console.log(err);
            if (recordset.recordsets.length == 0)
                res.end(JSON.stringify(null));            
            else
                res.end(JSON.stringify(recordset.recordsets[0])); // Result in JSON format but into a Array            
            sql.close();
        });
    });*/
})
