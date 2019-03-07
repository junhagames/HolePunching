global.serverTitle = get_string("서버 이름", 8);
global.serverDescription = get_string("서버 설명", string(global.playerName) + "의 분노의 게임방");
global.serverMaxPlayer = get_integer("서버 최대인원", 8);
isServerCreate = false;
playerList = ds_list_create();

net_registerServer();

alarm[0] = global.timeout;