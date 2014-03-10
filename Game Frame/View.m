//
//  View.m
//  Game Frame
//
//  Created by Michael Fogleman on 3/9/14.
//  Copyright (c) 2014 Michael Fogleman. All rights reserved.
//

#import "View.h"

#define kSize 16

@implementation View

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.mask = [NSImage imageNamed:@"mask"];
    }
    return self;
}

- (BOOL)isFlipped {
    return YES;
}

- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];
    [[NSColor blackColor] setFill];
    NSRectFill(dirtyRect);
    NSBitmapImageRep *bitmap = self.bitmap;
    if (!bitmap) {
        return;
    }
    int w = self.bounds.size.width;
    int h = self.bounds.size.height;
    int s = MIN(w, h);
    int size = (s - s / 16) / kSize;
    int ox = (w - size * kSize) / 2.0;
    int oy = (h - size * kSize) / 2.0;
    for (int i = 0; i < kSize; i++) {
        for (int j = 0; j < kSize; j++) {
            int x = ox + i * size;
            int y = oy + j * size;
            NSColor *color = [bitmap colorAtX:i y:j];
            float brightness = MIN(1.0, color.brightnessComponent * 1.25 + 0.15);
            color = [NSColor colorWithHue:color.hueComponent saturation:color.saturationComponent brightness:brightness alpha:color.alphaComponent];
            [color setFill];
            CGRect rect = NSMakeRect(x, y, size, size);
            NSRectFill(rect);
            [self.mask drawInRect:rect];
        }
    }
}

@end
