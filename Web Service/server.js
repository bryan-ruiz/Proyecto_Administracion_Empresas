/*
=================================================
=   Autor: Eliomar Antonio Rodríguez Arguedas   =
=                                               =
=   Web Service para el proyecto Acreditación   =
=   TEC                                         =
=================================================

===============================================================
>  Archivos donde estan los controladores en el servidor.     <
===============================================================
*/
var componenteCtrl = require('./Controladores/controladorComponentes'); // controlador de Componentes

/*
===============================================================================
>  Configuraciones principales del servidor, con esto escucha las peticiones  <
===============================================================================
*/
bodyParser = require('body-parser');
var express = require('express'),
    app = express(),
    server = require('http').createServer(app),
    port = 8080;
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
//Se direccionan las vistas. EL mismos server levanta las vistas.
app.use('/', express.static(__dirname + '/Web Service/'));

/*
===========================================
>  Inicio de las direcciones (Endpoints)  <
===========================================

==================================
>  EndPoints de los Componentes  <
==================================
*/
app.post('/insertComponente', componenteCtrl.insertComponente);
app.get('/selectComponentes', componenteCtrl.selectComponente);
app.post('/editComponente', componenteCtrl.editComponente);
app.post('/deleteComponenete', componenteCtrl.deleteComponente);

/*
==================================================================================
>  Pone el servidor en escucha de peticiones,lo levanta en el puerto requerido.  <
==================================================================================
*/

server.listen(port, function() {
    console.log('Servidor escuchando en el puerto: ' + port);
});