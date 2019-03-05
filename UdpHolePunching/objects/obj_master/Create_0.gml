socket = network_create_socket_ext(network_socket_udp, 7777);
buffer = buffer_create(1, buffer_grow, 1);

// 플레이어, 서버 리스트 생성 
playerList = ds_list_create();
serverList = ds_list_create();