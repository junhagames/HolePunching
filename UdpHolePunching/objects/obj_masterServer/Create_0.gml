socket = network_create_socket_ext(network_socket_udp, 7777);
buffer = buffer_create(1, buffer_grow, 1);
servers = 0;
players = 0;

// 플레이어, 서버 리스트 생성 
player_list = ds_list_create();
server_list = ds_list_create();