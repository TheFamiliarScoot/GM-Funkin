if local_socket > -1 {
	network_destroy(local_socket);	
}

var clen = array_length(clients);
for (var i = 0; i < clen; i++) {
	instance_destroy(clients[i]);	
}

network_destroy(server);