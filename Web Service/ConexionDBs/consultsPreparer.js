var Request = require('tedious').Request;
var TYPES = require('tedious').TYPES;
var sqlConection = require('./sqlConection.js');

/*
===========================
>  CRUD's de Componentes  <
>   - insert              <
>   - select              <
>   - edit                <
>   - delete              <
===========================
*/
exports.insertComponente = function insertComponente(datos, callback) {
    var request = new Request('insertComponente', function(err) { // nombre de procedimiento en la base de datos
        if (err) {
            callback({
                success: false,
                error: request.error,
                title: "Error",
                message: "Sucedio un error en la inserción de los datos",
                type: "error"
            })
        }
    });
    request.addParameter('nombreComponente', TYPES.VarChar, datos.nombreComponente);
    
    sqlConection.callProcedure(request, function(res) {
        callback(res);
    });
}

exports.selectComponente = function(callback) {   
    console.log('Preparar consulta'); 
    var query = "SELECT * FROM Componentes"; //Agregar procedimiento almacenado para esta consulta
    var request = new Request(query, function(err) {
        if (err) {
            callback({
                success: false,
                data: err,
                error: request.error,
                title: "Error",
                message: "Error obteniendo los datos. Revise su conexión",
                type: "error"
            });
        }
    });

    // se usa executeRequest porque es el destinado para escribir consultas desde aca en vez de llamar procedimientos almacenados
    sqlConection.executeRequest(request, callback); 
}

exports.editComponente = function editComponente(datos, callback) {
    var request = new Request('editComponente', function(err) {
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

    request.addParameter('ID_Componente', TYPES.Int, datos.ID);
    request.addParameter('nombreComponente', TYPES.VarChar, datos.nombreComponente);

    sqlConection.callProcedure(request, callback);
};
// DELETE 
exports.deleteComponente = function deleteComponente(datos, callback) {
    var request = new Request('deleteComponente', function(err) {
        if (err) {
            msg = (request.error == 1) ? "Error de conexión" : "No se puede eliminar el componente";
            callback({
                success: false,
                data: err,
                error: request.error,
                title: "Error",
                message: msg,
                type: "error"
            })
        }
    });
    request.addParameter('ID', TYPES.Int, datos.ID);

    sqlConection.callProcedure(request, callback);
}