server = network_create_server(network_socket_tcp, 38659, 4);
clients = [];

local_socket = network_create_socket(network_socket_tcp);
network_connect(local_socket, "127.0.0.1", 38659);
net_send_packet(data_type.profile, local_socket, {name: "Scooter", character: 11});
net_send_packet(data_type.chat, local_socket, {message: "Fuck you"});