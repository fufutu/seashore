#import "PluginData.h"
#import "SeaLayer.h"
#import "SeaDocument.h"
#import "SeaContent.h"
#import "SeaSelection.h"
#import "SeaWhiteboard.h"
#import "SeaHelpers.h"
#import "SeaController.h"
#import "SeaPrefs.h"
#import "EffectTool.h"
#import "SeaTools.h"

@implementation PluginData

- (IntRect)selection
{
	if ([[(SeaDocument *)document selection] active])
		return [[(SeaDocument *)document selection] localRect];
	else
		return IntMakeRect(0, 0, [(SeaLayer *)[[document contents] activeLayer] width], [(SeaLayer *)[[document contents] activeLayer] height]);
}

- (unsigned char *)data
{
	return [(SeaLayer *)[[document contents] activeLayer] data];
}

- (unsigned char *)whiteboardData
{
	return [(SeaWhiteboard *)[document whiteboard] data];
}

- (unsigned char *)replace
{
	return [(SeaWhiteboard *)[document whiteboard] replace];
}

- (unsigned char *)overlay
{
	return [(SeaWhiteboard *)[document whiteboard] overlay];
}

- (int)spp
{
	return [[document contents] spp];
}

- (int)channel
{
    return [[document contents] selectedChannel];	
}

- (int)width
{
	return [(SeaLayer *)[[document contents] activeLayer] width];
}

- (int)height
{
	return [(SeaLayer *)[[document contents] activeLayer] height];
}

- (BOOL)hasAlpha
{
	return [(SeaLayer *)[[document contents] activeLayer] hasAlpha];
}

- (IntPoint)point:(int)index;
{
	return [[[document tools] getTool:kEffectTool] point:index];
}

- (NSColor *)foreColor
{
    return [[document contents] foreground];
}

- (NSColor *)backColor
{
    return [[document contents] background];
}

- (id)window
{
	if ([[SeaController seaPrefs] effectsPanel])
		return NULL;
	else
		return [document window];
}

- (void)setOverlayBehaviour:(int)value
{
	[[document whiteboard] setOverlayBehaviour:value];
}

- (void)setOverlayOpacity:(int)value
{
	[[document whiteboard] setOverlayOpacity:value];
}

- (void)apply
{
	[(SeaHelpers *)[document helpers] applyOverlay];
}

- (void)preview
{
	[(SeaHelpers *)[document helpers] overlayChanged:[self selection]];
}

- (void)cancel
{
	[(SeaWhiteboard *)[document whiteboard] clearOverlay];
	[(SeaHelpers *)[document helpers] overlayChanged:[self selection]];
}

@end
