/// @description 자신의 사설 IP를 가져옵니다. 네트워크 이벤트 -> async_load[? "ip"]

var port = 50000;
var listen = network_create_server(network_socket_udp, port, 1);

if (listen < 0) {
	show_message("사설 IP를 가져오는데 실패했습니다!");
	game_end();
}
else {
	var sock = network_create_socket(network_socket_udp);
	var buff = buffer_create(1, buffer_grow, 1);
	buffer_write(buff, buffer_u16, COMMAND.PLAYER_FINDING_PRIVATEIP);
	network_send_broadcast(sock, port, buff, buffer_tell(buff));	
	network_destroy(sock);
	buffer_delete(buff);
}