socket = network_create_socket_ext(network_socket_udp, get_integer("[게임서버] 호스팅할 게임서버 소켓 포트", 2620));
hash = net_hashCreate(4);
name = get_string("[게임서버] 호스팅할 게임서버 이름", "짱짱서버");
master_ip = get_string("[게임서버] 접속할 마스터서버 IP", "127.0.0.1");
master_port = get_integer("[게임서버] 접속할 마스터서버 PORT", 7777);
buffer = buffer_create(1, buffer_grow, 1);
isConnected = false;

// 플레이어 리스트 생성
player_list = ds_list_create();

// 마스터서버에 게임서버 등록
buffer_seek(buffer, buffer_seek_start, 0);
buffer_write(buffer, buffer_u8, PACKET.GAMESERVER_REGISTER);
buffer_write(buffer, buffer_string, hash);
buffer_write(buffer, buffer_string, name);
network_send_udp(socket, master_ip, master_port, buffer, buffer_tell(buffer));

// 마스터서버 연결시간 초과
alarm[0] = room_speed * 4;

