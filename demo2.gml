// oPlayer - Draw End event
// Renders shadows based on player's position to walls.
// Currently only renders that which the player should be able to see (good).
// However, looking at a corner of two walls that meet convexly (like looking at an "L" from the bottom left) produces artifacts (bad).

if (!surface_exists(shadowSurface)) {
    shadowSurface = surface_create(oCamera.view_width, oCamera.view_height);
}

surface_set_target(shadowSurface);
draw_clear(c_black);

var shadowLength = SHADOW_LENGTH;
var originalDrawColor = draw_get_color();

with (oWall) {
    // for the subtract blendmode:
    // * use white to make areas black
    // * use black to keep areas as-is
    draw_set_color(c_white);

    var playerX = other.x;
    var playerY = other.y;
    var playerToTopLeft = point_direction(playerX, playerY, bbox_left, bbox_top);
    var playerToBottomLeft = point_direction(playerX, playerY, bbox_left, bbox_bottom);
    var playerToTopRight = point_direction(playerX, playerY, bbox_right, bbox_top);
    var playerToBottomRight = point_direction(playerX, playerY, bbox_right, bbox_bottom);

    draw_primitive_begin(pr_trianglestrip);
        if (playerX < bbox_left && playerY > bbox_bottom) {
            draw_vertex(bbox_left, bbox_top);
            draw_vertex(x + lengthdir_x(shadowLength, playerToTopLeft), y + lengthdir_y(shadowLength, playerToTopLeft));
            draw_vertex(bbox_right, bbox_top);
            draw_vertex(x + lengthdir_x(shadowLength, playerToTopRight), y + lengthdir_y(shadowLength, playerToTopRight));
            draw_vertex(bbox_right, bbox_bottom);
            draw_vertex(x + lengthdir_x(shadowLength, playerToBottomRight), y + lengthdir_y(shadowLength, playerToBottomRight));
            //draw_vertex(x + lengthdir_x(shadowLength, ), y + lengthdir_y(shadowLength, ));
        } else if (playerX < bbox_left && playerY < bbox_top) {
            draw_vertex(bbox_right, bbox_top);
            draw_vertex(x + lengthdir_x(shadowLength, playerToTopRight), y + lengthdir_y(shadowLength, playerToTopRight));
            draw_vertex(bbox_right, bbox_bottom);
            draw_vertex(x + lengthdir_x(shadowLength, playerToBottomRight), y + lengthdir_y(shadowLength, playerToBottomRight));
            draw_vertex(bbox_left, bbox_bottom);
            draw_vertex(x + lengthdir_x(shadowLength, playerToBottomLeft), y + lengthdir_y(shadowLength, playerToBottomLeft));
        } else if (playerX > bbox_right && playerY < bbox_top) {
            draw_vertex(bbox_right, bbox_bottom);
            draw_vertex(x + lengthdir_x(shadowLength, playerToBottomRight), y + lengthdir_y(shadowLength, playerToBottomRight));
            draw_vertex(bbox_left, bbox_bottom);
            draw_vertex(x + lengthdir_x(shadowLength, playerToBottomLeft), y + lengthdir_y(shadowLength, playerToBottomLeft));
            draw_vertex(bbox_left, bbox_top);
            draw_vertex(x + lengthdir_x(shadowLength, playerToTopLeft), y + lengthdir_y(shadowLength, playerToTopLeft));
        } else if (playerX > bbox_right && playerY > bbox_bottom) {
            draw_vertex(bbox_left, bbox_bottom);
            draw_vertex(x + lengthdir_x(shadowLength, playerToBottomLeft), y + lengthdir_y(shadowLength, playerToBottomLeft));
            draw_vertex(bbox_left, bbox_top);
            draw_vertex(x + lengthdir_x(shadowLength, playerToTopLeft), y + lengthdir_y(shadowLength, playerToTopLeft));
            draw_vertex(bbox_right, bbox_top);
            draw_vertex(x + lengthdir_x(shadowLength, playerToTopRight), y + lengthdir_y(shadowLength, playerToTopRight));
        } else if (playerY > bbox_bottom) {
            draw_vertex(bbox_left, bbox_bottom);
            draw_vertex(x + lengthdir_x(shadowLength, playerToBottomLeft), y + lengthdir_y(shadowLength, playerToBottomLeft));
            draw_vertex(bbox_left, bbox_top);
            draw_vertex(x + lengthdir_x(shadowLength, playerToTopLeft), y + lengthdir_y(shadowLength, playerToTopLeft));
            draw_vertex(bbox_right, bbox_top);
            draw_vertex(x + lengthdir_x(shadowLength, playerToTopRight), y + lengthdir_y(shadowLength, playerToTopRight));
            draw_vertex(bbox_right, bbox_bottom);
            draw_vertex(x + lengthdir_x(shadowLength, playerToBottomRight), y + lengthdir_y(shadowLength, playerToBottomRight));
        } else if (playerX < bbox_left) {
            draw_vertex(bbox_left, bbox_top);
            draw_vertex(x + lengthdir_x(shadowLength, playerToTopLeft), y + lengthdir_y(shadowLength, playerToTopLeft));
            draw_vertex(bbox_right, bbox_top);
            draw_vertex(x + lengthdir_x(shadowLength, playerToTopRight), y + lengthdir_y(shadowLength, playerToTopRight));
            draw_vertex(bbox_right, bbox_bottom);
            draw_vertex(x + lengthdir_x(shadowLength, playerToBottomRight), y + lengthdir_y(shadowLength, playerToBottomRight));
            draw_vertex(bbox_left, bbox_bottom);
            draw_vertex(x + lengthdir_x(shadowLength, playerToBottomLeft), y + lengthdir_y(shadowLength, playerToBottomLeft));
        } else if (playerY < bbox_top) {
            draw_vertex(bbox_right, bbox_top);
            draw_vertex(x + lengthdir_x(shadowLength, playerToTopRight), y + lengthdir_y(shadowLength, playerToTopRight));
            draw_vertex(bbox_right, bbox_bottom);
            draw_vertex(x + lengthdir_x(shadowLength, playerToBottomRight), y + lengthdir_y(shadowLength, playerToBottomRight));
            draw_vertex(bbox_left, bbox_bottom);
            draw_vertex(x + lengthdir_x(shadowLength, playerToBottomLeft), y + lengthdir_y(shadowLength, playerToBottomLeft));
            draw_vertex(bbox_left, bbox_top);
            draw_vertex(x + lengthdir_x(shadowLength, playerToTopLeft), y + lengthdir_y(shadowLength, playerToTopLeft));
        } else if (playerX > bbox_right) {
            draw_vertex(bbox_right, bbox_bottom);
            draw_vertex(x + lengthdir_x(shadowLength, playerToBottomRight), y + lengthdir_y(shadowLength, playerToBottomRight));
            draw_vertex(bbox_left, bbox_bottom);
            draw_vertex(x + lengthdir_x(shadowLength, playerToBottomLeft), y + lengthdir_y(shadowLength, playerToBottomLeft));
            draw_vertex(bbox_left, bbox_top);
            draw_vertex(x + lengthdir_x(shadowLength, playerToTopLeft), y + lengthdir_y(shadowLength, playerToTopLeft));
            draw_vertex(bbox_right, bbox_top);
            draw_vertex(x + lengthdir_x(shadowLength, playerToTopRight), y + lengthdir_y(shadowLength, playerToTopRight));
        }
    draw_primitive_end();
}

draw_set_color(originalDrawColor);

surface_reset_target();

gpu_set_blendmode(bm_subtract);
draw_surface(shadowSurface, 0, 0);
gpu_set_blendmode(bm_normal);
