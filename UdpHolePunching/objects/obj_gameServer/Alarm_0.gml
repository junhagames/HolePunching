if (connected == false) {
	network_destroy(listen);
	buffer_delete(buffer);
	
	show_message("[게임서버] 마스터서버 연결 시간이 초과됐습니다!");
	game_end();
}