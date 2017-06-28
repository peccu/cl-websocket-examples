var socket = require('engine.io-client')('ws://127.0.0.1:3456');
socket.on('open', function(){
  console.log('open');
  socket.on('message', function(data){
    console.log('message', data);
  });
  socket.on('close', function(){
    console.log('close');
  });
  socket.send('abc');
});
socket.on('error', function(e){
  console.log('error', e);
});
