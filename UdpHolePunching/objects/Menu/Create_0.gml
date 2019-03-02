menu = get_integer(string_hash_to_newline("서버:		{1}#클라이언트:	{2}"), "");

if (menu == 1) {
	instance_create_layer(0, 0, "layer_instance", Server);
	show_message("1");
}
else if (menu == 2) {
	instance_create_layer(0, 0, "layer_instance", Client);
	show_message("2");
}

instance_destroy();