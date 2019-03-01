listen = network_create_socket_ext(network_socket_udp, get_integer("[게임서버] 호스팅할 게임서버 포트", 2620));
name = get_string("[게임서버] 호스팅할 게임서버 이름", "짱짱서버");
master_ip = get_string("[게임서버] 접속할 마스터서버 IP", "127.0.0.1");
master_port = get_integer("[게임서버] 접속할 마스터서버 PORT", 7777);
buffer = buffer_create(1, buffer_grow, 1);
connected = false;
players = 0;

// 플레이어 배열 초기화
for (i = 0; i < 100; i++) {
	player[i] = ds_map_create();
    ds_map_add(player[i], "id", 0);
    ds_map_add(player[i], "name", "");
}

// 마스터서버에 게임서버 등록
buffer_write(buffer, buffer_u8, PACKET.GAMESERVER_REG);
buffer_write(buffer, buffer_string, name);
network_send_udp(listen, master_ip, master_port, buffer, buffer_tell(buffer));

// 마스터서버 연결 시간 초과
alarm[0] = room_speed * 4;

