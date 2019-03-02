draw_set_color(c_lime);
draw_text(0, 0, "<" + name + "게임서버: " + string(hash) + ">");
draw_set_color(c_white);
draw_text(0, 32, "접속자수: " + string(players));

if (!connected) {
	draw_set_color(c_yellow);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(room_width / 2, room_height / 2, "마스터서버 연결중...");
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}