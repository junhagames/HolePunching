var buff = async_load[? "buffer"];

if (buffer_read(buff, buffer_u8) == COMMAND.MASTER_CLOSE) {
	show_message("마스터서버가 종료되었습니다!");
	game_end();
}