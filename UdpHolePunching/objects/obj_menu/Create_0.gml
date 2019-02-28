var type = get_integer(string_hash_to_newline("게임서버:	{1}#클라이언트:	{2}#마스터서버	{3}##게임종료	{4}"), "");

switch (type) {
	case 1:
		instance_create_depth(0, 0, 0, obj_gameServer);
		instance_destroy();
		break;
		
	case 2:
		instance_create_depth(0, 0, 0, obj_client);
		instance_destroy();
		break;
		
	case 3:
		instance_create_depth(0, 0, 0, obj_masterServer);
		instance_destroy();
		break;
		
	case 4:
		game_end();
		break;
		
	default:
		show_message("잘못된 값입니다!");
		event_perform(ev_create, 0);
		break;
}
