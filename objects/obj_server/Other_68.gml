var type = ds_map_find_value(async_load, "type");
switch type {
	case network_type_connect:
		// for now accepting anyone is fine
		// in the future there will need to be a handshake system
		show_debug_message("Client connected");
		var socket = ds_map_find_value(async_load, "socket");
		var ip = ds_map_find_value(async_load, "ip");
		array_push(clients, instance_create_depth(0, 0, 0, obj_client, {client: socket, client_ip: ip}));
		net_send_packet_all(data_type.profile, clients, {client_id: array_length(clients) - 1, name: "Player", character: 0});
		break;
	case network_type_disconnect:
		var socket = ds_map_find_value(async_load, "socket");
		remove_client_by_socket(id, socket);
		show_debug_message("Client disconnected");
		break;
	case network_type_data:
		var socket = ds_map_find_value(async_load, "id");
		var data = net_read_packet(ds_map_find_value(async_load, "buffer"));
		
		// CLIENT-BOUND
		if socket == server {
			show_debug_message("client-bound");
		}
		// SERVER-BOUND
		else {
			show_debug_message("server-bound");
			var client = find_client_by_socket(id, socket);
			switch data.type {
				case data_type.profile:
					client.client_id = data.client_id;
					client.name = data.name;
					client.character = data.character;
					break;
				case data_type.chat:
					net_send_packet_all(data_type.chat, clients, {message: data.message});
					//show_debug_message(client.name + " says: " + data.message);
					break;
			}
		}
		break;
}