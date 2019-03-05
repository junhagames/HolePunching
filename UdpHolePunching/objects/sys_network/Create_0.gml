var select = get_integer("마스터 호스팅 : {1}", "0");

if (select == 1) {
	// 마스터서버 생성
	with (obj_loby) {
		instance_destroy();
	}
	with (obj_serverCreateBtn) {
		instance_destroy();
	}
	with (obj_directConnectBtn) {
		instance_destroy();
	}
	instance_create_depth(0, 0, 0, obj_master);
}
else {
	// 플레이어 생성
	net_init();
}