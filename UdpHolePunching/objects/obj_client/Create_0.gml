socket = network_create_socket_ext(network_socket_udp, get_integer("[클라이언트] 클라이언트 소켓 포트", 25565));
hash = net_hashCreate(8);
name = get_string("[클라이언트] 플레이어 닉네임", "강건마");
master_ip = get_string("[클라이언트] 접속할 마스터서버 IP", "127.0.0.1");
master_port = get_integer("[클라이언트] 접속할 마스터서버 PORT", 7777);
server_ip = get_string("[클라이언트] 접속할 게임서버 IP", "127.0.0.1");
server_port = get_integer("[클라이언트] 접속할 게임서버 PORT", 2620);
buffer = buffer_create(1, buffer_grow, 1);
isConnected = false;

// 마스터서버를 거처 게임서버에게 플레이어 정보 알리기
buffer_write(buffer, buffer_u8, PACKET.CLIENT_REGISTER);
buffer_write(buffer, buffer_string, server_ip);
buffer_write(buffer, buffer_u16, server_port);
buffer_write(buffer, buffer_string, hash);
buffer_write(buffer, buffer_string, name);
network_send_udp(socket, master_ip, master_port, buffer, buffer_tell(buffer));

// 마스터서버 연결 시간 초과
alarm[0] = room_speed * 4;

