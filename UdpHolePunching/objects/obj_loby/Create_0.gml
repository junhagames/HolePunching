global.masterIp = get_string("접속할 마스터서버 IP", "127.0.0.1");
global.masterPort = get_integer("접속할 마스터서버 PORT", 7777);
buffer = buffer_create(1, buffer_grow, 1);
isMasterConnecting = false;
isMasterConnected = false;

net_getPrivateIp();

// 마스터서버 연결시간 초과
alarm[0] = global.timeout;