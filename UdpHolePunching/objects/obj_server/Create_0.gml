socket = network_create_socket_ext(network_socket_udp, get_integer("[게임서버] 호스팅할 게임서버 소켓 포트", 2620));
hash = net_createHash(4);
name = get_string("호스팅할 게임서버 이름", "짱짱서버");
master_ip = get_string("접속할 마스터서버 IP", "127.0.0.1");
master_port = get_integer("접속할 마스터서버 PORT", 7777);


