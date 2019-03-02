draw_set_color(c_lime);
draw_text(0, 0, "<" + name + " 클라이언트: " + string(hash) + ">");
draw_set_color(c_white);

if (!isConnected) {
	draw_set_color(c_yellow);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(room_width / 2, room_height / 2, "마스터서버 연결중...");
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}