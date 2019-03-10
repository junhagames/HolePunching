/// @description 플레이어를 조작합니다
/// @param left
/// @param right
/// @param up
/// @param down

var keyLeft = keyboard_check(argument0);
var keyRight = keyboard_check(argument1);
var keyUp = keyboard_check(argument2);
var keyDown = keyboard_check(argument3);

playerHspeed = (keyRight - keyLeft) * playerSpeed;
playerVspeed = (keyDown - keyUp) * playerSpeed;
var isMove = (playerHspeed != 0) || (playerVspeed != 0);

x += lengthdir_x(playerSpeed * isMove, point_direction(x, y, x + playerHspeed, y + playerVspeed));
y += lengthdir_y(playerSpeed * isMove, point_direction(x, y, x + playerHspeed, y + playerVspeed));

playerAngle = point_direction(x, y, mouse_x, mouse_y);