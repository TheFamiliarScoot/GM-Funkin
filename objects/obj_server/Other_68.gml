var type = ds_map_find_value(async_load, "type");
switch type {
	case network_type_connect:
		// for now accepting anyone is fine
		// in the future there will need to be a handshake system
		show_debug_message("Client connected");
		var socket = ds_map_find_value(async_load, "socket");
		var ip = ds_map_find_value(async_load, "ip");
		array_push(clients, instance_create_depth(0, 0, 0, obj_client, {client: socket, client_ip: ip}));
		break;
	case network_type_disconnect:
		var socket = ds_map_find_value(async_load, "socket");
		remove_client_by_socket(id, socket);
		show_debug_message("Client disconnected");
		break;
	case network_type_data:
		var socket = ds_map_find_value(async_load, "id");
		var client = find_client_by_socket(id, socket);
		var data = net_read_packet(ds_map_find_value(async_load, "buffer"));
		switch data.type {
			case data_type.profile:
				client.name = data.name;
				client.character = data.character;
				break;
			case data_type.chat:
				show_debug_message(client.name + " says: " + data.message);
				break;
		}
		break;
}