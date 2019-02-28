listen = network_create_socket_ext(network_socket_udp, 7777);
buffer = buffer_create(1, buffer_grow, 1);
servers = 0;
players = 0;

for (var i = 0; i < 100; i++) {
	// 플레이어 배열 초기화
	player[i] = ds_map_create();
	ds_map_add(player[i], "name", "");
	ds_map_add(player[i], "ip", "");
	ds_map_add(player[i], "port", 0);
	
	// 게임서버 배열 초기화
	server[i] = ds_map_create();
	ds_map_add(server[i], "name", "");
	ds_map_add(server[i], "ip", "");
	ds_map_add(server[i], "port", 0);
}

