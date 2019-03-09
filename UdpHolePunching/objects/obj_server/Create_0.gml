global.serverTitle = get_string("게임서버 이름", string(global.playerName) + "의 흐뭇한 게임방");
global.serverDescription = get_string("게임서버 설명", "꿀잼보장ㅎ");
global.serverMaxPlayer = get_integer("게임서버 최대인원 (2-255)", 8);
playerList = ds_list_create();
isServerCreated = false;

net_registerServer();

alarm[0] = global.timeout;