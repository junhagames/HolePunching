socket = network_create_socket(network_socket_tcp);
var err = network_connect(socket, "127.0.0.1", 8888);
show_message(err);