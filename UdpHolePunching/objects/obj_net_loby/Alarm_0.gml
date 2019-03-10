if (!global.isMasterConnected) {
	show_message("마스터서버 연결시간이 초과되었습니다!");
	game_end();
	
	// TODO LAN 멀티플레이어
}