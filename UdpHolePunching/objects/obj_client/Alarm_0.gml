if (connected == false) {
	show_message("[클라이언트] 마스터서버 연결 시간이 초과됐습니다!");
	
	network_destroy(socket);
	buffer_delete(buffer);
	game_end();
}