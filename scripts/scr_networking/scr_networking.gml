enum data_type {
	profile,
	chat
}

function find_client_by_socket(server, socket) {
	var cl = array_length(server.clients);
	for (var i = 0; i < cl; i++) {
		if server.clients[i].client == socket {
			return server.clients[i];
		}
	}
}

function remove_client_by_socket(server, socket) {
	var cl = array_length(server.clients);
	for (var i = 0; i < cl; i++) {
		if server.clients[i].client == socket {
			server.clients[i].disconnected = true;
			instance_destroy(server.clients[i]);
			array_delete(server.clients, i, 1);
			break;
		}
	}
}

function net_send_packet(type, socket, data_struct) {
	var buf = buffer_create(1, buffer_grow, 1);
	buffer_write(buf, buffer_u8, type);
	switch type {
		case data_type.profile:
			buffer_write(buf, buffer_string, data_struct.name);
			buffer_write(buf, buffer_u8, data_struct.character);
			break;
		case data_type.chat:
			buffer_write(buf, buffer_string, data_struct.message);
			break;
	}
	network_send_packet(socket, buf, buffer_get_size(buf));
	buffer_delete(buf);
}

function net_read_packet(buf) {
	var type = buffer_read(buf, buffer_u8);
	var data_struct = {};
	data_struct.type = type;
	switch type {
		case data_type.profile:
			data_struct.name = buffer_read(buf, buffer_string);
			data_struct.character = buffer_read(buf, buffer_u8);
			break;
		case data_type.chat:
			data_struct.message = buffer_read(buf, buffer_string);
			break;
	}
	return data_struct;
}