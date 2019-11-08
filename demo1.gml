// oPlayer - Draw End event
// Renders shadows based on player's position to walls.
// Currently renders all walls, no matter if the player should be able to see them.

if (!surface_exists(shadowSurface)) {
    shadowSurface = surface_create(oCamera.view_width, oCamera.view_height);
}

surface_set_target(shadowSurface);
draw_clear(c_black);

var shadowLength = SHADOW_LENGTH;
var originalDrawColor = draw_get_color();

with (oWall) {
    draw_set_color(c_white);

    var playerToTopLeft = point_direction(other.x, other.y, bbox_left, bbox_top);
    var playerToBottomLeft = point_direction(other.x, other.y, bbox_left, bbox_bottom);
    var playerToTopRight = point_direction(other.x, other.y, bbox_right, bbox_top);
    var playerToBottomRight = point_direction(other.x, other.y, bbox_right, bbox_bottom);

    draw_primitive_begin(pr_trianglestrip);
        draw_vertex(bbox_left, bbox_top);
        draw_vertex(x + lengthdir_x(shadowLength, playerToTopLeft), y + lengthdir_y(shadowLength, playerToTopLeft));
        draw_vertex(bbox_left, bbox_bottom);
        draw_vertex(x + lengthdir_x(shadowLength, playerToBottomLeft), y + lengthdir_y(shadowLength, playerToBottomLeft));
        draw_vertex(bbox_right, bbox_top);
        draw_vertex(x + lengthdir_x(shadowLength, playerToTopRight), y + lengthdir_y(shadowLength, playerToTopRight));
        draw_vertex(bbox_right, bbox_bottom);
        draw_vertex(x + lengthdir_x(shadowLength, playerToBottomRight), y + lengthdir_y(shadowLength, playerToBottomRight));
    draw_primitive_end();
}

with (oWall) {
    draw_set_color(c_black);
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
}

draw_set_color(originalDrawColor);

surface_reset_target();

gpu_set_blendmode(bm_subtract);
draw_surface(shadowSurface, 0, 0);
gpu_set_blendmode(bm_normal);


exit;

// messing around below, lol

var maxX = oCamera.view_width / 2;
var maxY = oCamera.view_height / 2;
var originalDrawColor = draw_get_color();

surface_set_target(shadowSurface);
draw_clear_alpha(c_black, 0);
// for the subtract blendmode, use white to make areas black
draw_set_color(c_white);
draw_triangle(0, 0, maxX, 0, 0, maxY, false);
// for the subtract blendmode, use black to keep areas as-is
draw_set_color(c_black);
draw_triangle(maxX, maxY, 0, maxY, maxX, 0, false);
draw_set_color(originalDrawColor);
surface_reset_target();

gpu_set_blendmode(bm_subtract);
draw_surface(shadowSurface, 0, 0);
gpu_set_blendmode(bm_normal);
