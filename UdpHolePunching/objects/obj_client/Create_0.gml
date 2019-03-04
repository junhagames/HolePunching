socket = network_create_socket_ext(network_socket_udp, get_integer("[클라이언트] 플레이어 소켓 포트", 25565));
hash = net_hashCreate(8);
name = get_string("[클라이언트] 플레이어 닉네임", "강건마");
master_ip = get_string("[클라이언트] 접속할 마스터서버 IP", "127.0.0.1");
master_port = get_integer("[클라이언트] 접속할 마스터서버 PORT", 7777);
buffer = buffer_create(1, buffer_grow, 1);
isConnecting = false;
isConnected = false;