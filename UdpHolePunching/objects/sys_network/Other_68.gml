var buff = async_load[? "buffer"];

if (buffer_read(buff, buffer_u8) == COMMAND.MASTER_CLOSE) {
	show_message("마스터서버가 종료되었습니다!");
	game_end();
}

if (buffer_read(buff, buffer_u8) == COMMAND.PLAYER_REGISTER_MASTER) {
	show_message("[네트워크] 플레이어 추가!");
	game_end();
}