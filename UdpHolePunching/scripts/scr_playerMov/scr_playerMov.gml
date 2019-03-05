/// @description 플레이어를 조작합니다
/// @param left
/// @param right
/// @param up
/// @param down

var key_left = keyboard_check(argument0);
var key_right = keyboard_check(argument1);
var key_up = keyboard_check(argument2);
var key_down = keyboard_check(argument3);

player_hspd = (key_right - key_left) * player_spd;
player_vspd = (key_down - key_up) * player_spd;
var isMove = (player_hspd != 0) || (player_vspd != 0);

x += lengthdir_x(player_spd * isMove, point_direction(x, y, x + player_hspd, y + player_vspd));
y += lengthdir_y(player_spd * isMove, point_direction(x, y, x + player_hspd, y + player_vspd));

player_angle = point_direction(x, y, mouse_x, mouse_y);