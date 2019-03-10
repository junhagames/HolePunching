draw_set_color(c_lime);
draw_text(0, 0, "<로비>");
draw_set_color(c_white);

draw_text(0, 16, global.hash + " | " + global.playerName);

if (!global.isMasterConnected) {
	draw_set_color(c_yellow);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(room_width / 2, room_height / 2, "마스터서버 접속중...");
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}