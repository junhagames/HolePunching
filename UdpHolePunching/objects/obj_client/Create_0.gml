socket = network_create_socket_ext(network_socket_udp,get_integer(string_hash_to_newline("[클라이언트] 연결할 포트#{기본값}: 25565"), 25565));
myname = get_string("[클라이언트] 플레이어 닉네임", "늅늅이");
master_ip = get_string("[클라이언트] 접속할 마스터서버 IP", "127.0.0.1");
master_port = get_integer(string_hash_to_newline("[클라이언트] 접속할 마스터서버 PORT#{기본값}: 7777"), 7777);
server_ip = get_string("[클라이언트] 접속할 게임서버 IP", "127.0.0.1");
server_port = get_integer(string_hash_to_newline("[클라이언트] 접속할 게임서버 PORT#{기본값}: 2620"), 2620);
buffer = buffer_create(1, buffer_grow, 1);
myid = 0;
connected = false;

// 마스터서버를 거처 게임서버에게 클라이언트 닉네임, 아이피, 포트 알리기
// UDP hole punching 1단계
buffer_write(buffer, buffer_u8, PACKET.CLIENT_REG);
buffer_write(buffer, buffer_string, server_ip);
buffer_write(buffer, buffer_u16, server_port);
buffer_write(buffer, buffer_string, myname);
network_send_udp(socket, master_ip, master_port, buffer, buffer_tell(buffer));

// 마스터서버 연결 시간 초과
alarm[0] = room_speed * 4;

