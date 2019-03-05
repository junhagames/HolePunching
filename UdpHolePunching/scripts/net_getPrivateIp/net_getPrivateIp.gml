/// @description 사설 IP를 가져옵니다. 네트워크 이벤트 async_load[? "ip"]

var port = 7878;
var host = network_create_server(network_socket_udp, port, 5);

if (host < 0) {
	show_message("브로드캐스트 생성에 실패했습니다!");
	game_end();
}
else {
	var sock = network_create_socket(network_socket_udp);
	var buff = buffer_create(32, buffer_fixed, 1);
	buffer_fill(buff, 0, buffer_bool, 0, 32);
	network_send_broadcast(sock, port, buff, buffer_get_size(buff));
	network_destroy(sock);
	buffer_delete(buff);
}