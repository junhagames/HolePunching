global.masterIp = get_string("접속할 마스터서버 IP", "127.0.0.1");
global.masterPort = get_integer("접속할 마스터서버 PORT", 7777);
isMasterConnected = false;

net_registerPlayer();

// 마스터서버 연결시간 초과
alarm[0] = global.timeout;