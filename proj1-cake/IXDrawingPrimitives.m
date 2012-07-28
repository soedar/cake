//
//  IXDrawingPrimitives.m
//  proj1-cake
//
//  Created by soedar on 27/7/12.
//
//

#import "IXDrawingPrimitives.h"

/**
 * Draws the lines that separate each piece of of the circle
 */
void ixDrawOverlay(CGPoint center, float radius, int parts)
{
    float alpha = M_PI*2/parts;
    for (int i=0;i<parts;i++) {
        float rad = alpha * i;
        float x = radius * sinf(rad);
        float y = radius * cosf(rad);
        
        ccDrawLine(center, ccp(center.x+x,center.y+y));
    }
}

/**
 * Draws the circle when the player highlights the piece
 */
void ixDrawHighlight(CGPoint center, float radius, float startAngle, float endAngle)
{
    int steps = 1000;
    
    float delta = endAngle - startAngle;
    if (delta < 0) {
        return;
    }
    
    int segs = (steps / (2*M_PI)) * delta;
	
	GLfloat *vertices = calloc( sizeof(GLfloat)*2*(segs)+1, 1);
	if( ! vertices )
		return;
    
    delta /= segs;
    float rads = startAngle;
    
    vertices[0] = center.x * CC_CONTENT_SCALE_FACTOR();
    vertices[1] = center.y * CC_CONTENT_SCALE_FACTOR();
	for(NSUInteger i=1;i<=segs;i++)
	{
		GLfloat j = radius * sinf(rads) + center.x;
		GLfloat k = radius * cosf(rads) + center.y;
		
		vertices[i*2] = j * CC_CONTENT_SCALE_FACTOR();
		vertices[i*2+1] = k * CC_CONTENT_SCALE_FACTOR();
        
        rads += delta;
	}

	// Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	// Needed states: GL_VERTEX_ARRAY,
	// Unneeded states: GL_TEXTURE_2D, GL_TEXTURE_COORD_ARRAY, GL_COLOR_ARRAY
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisableClientState(GL_COLOR_ARRAY);
	
	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glDrawArrays(GL_TRIANGLE_FAN, 0, (GLsizei) segs+1);
	
	// restore default state
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_TEXTURE_2D);
	
	free( vertices );
}