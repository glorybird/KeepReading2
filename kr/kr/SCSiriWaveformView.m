//
//  SCSiriWaveformView.m
//  SCSiriWaveformView
//
//  Created by Stefan Ceriu on 12/04/2014.
//  Copyright (c) 2014 Stefan Ceriu. All rights reserved.
//

#import "SCSiriWaveformView.h"

static const CGFloat kDefaultFrequency          = 1.5f;
static const CGFloat kDefaultAmplitude          = 1.0f;
static const CGFloat kDefaultIdleAmplitude      = 0.01f;
static const CGFloat kDefaultNumberOfWaves      = 5.0f;
static const CGFloat kDefaultPhaseShift         = -0.15f;
static const CGFloat kDefaultDensity            = 5.0f;
static const CGFloat kDefaultPrimaryLineWidth   = 3.0f;
static const CGFloat kDefaultSecondaryLineWidth = 1.0f;

@interface SCSiriWaveformView ()

@property (nonatomic, assign) CGFloat phase;
@property (nonatomic, assign) CGFloat amplitude;

@end

@implementation SCSiriWaveformView

- (instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		[self setup];
	}
	
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		[self setup];
	}
	
	return self;
}

- (void)setup
{
	self.waveColor = [UIColor whiteColor];
	
	self.frequency = kDefaultFrequency;
	
	self.amplitude = kDefaultAmplitude;
	self.idleAmplitude = kDefaultIdleAmplitude;
	
	self.numberOfWaves = kDefaultNumberOfWaves;
	self.phaseShift = kDefaultPhaseShift;
	self.density = kDefaultDensity;
	
	self.primaryWaveLineWidth = kDefaultPrimaryLineWidth;
	self.secondaryWaveLineWidth = kDefaultSecondaryLineWidth;
}

- (void)updateWithLevel:(CGFloat)level
{
	self.phase += self.phaseShift;
	self.amplitude = fmax(level, self.idleAmplitude);
	
	[self setNeedsDisplay];
}

// Thanks to Raffael Hannemann https://github.com/raffael/SISinusWaveView
- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClearRect(context, self.bounds);
	
	[self.backgroundColor set];
	CGContextFillRect(context, rect);
	
    [self.waveColor set];
    
	// We draw multiple sinus waves, with equal phases but altered amplitudes, multiplied by a parable function.
	for (int i = 0; i < self.numberOfWaves; i++) {
		CGContextRef context = UIGraphicsGetCurrentContext();
		
		CGContextSetLineWidth(context, (i == 0 ? self.primaryWaveLineWidth : self.secondaryWaveLineWidth));
		
		CGFloat width = CGRectGetWidth(self.bounds);
		CGFloat mid = width / 2.0f;
		
        CGFloat waveHeight = self.frame.size.height - (CGRectGetHeight(self.bounds) - 10) * self.stage;

		const CGFloat maxAmplitude = self.frame.size.height - waveHeight - 4.0f; // 4 corresponds to twice the stroke width
		
		// Progress is a value between 1.0 and -0.5, determined by the current wave idx, which is used to alter the wave's amplitude.
		CGFloat progress = 1.0f - (CGFloat)i / self.numberOfWaves;
		CGFloat normedAmplitude = (1.5f * progress - 0.5f) * self.amplitude;
		
		
		
		for (CGFloat x = 0; x<width + self.density; x += self.density) {
			// We use a parable to scale the sinus wave, that has its peak in the middle of the view.
			CGFloat scaling = -pow(1 / mid * (x - mid), 2) + 1;
            CGFloat y = scaling * maxAmplitude * normedAmplitude * sinf(2 * M_PI *(x / width) * self.frequency + self.phase) + waveHeight;
			
			if (x == 0) {
				CGContextMoveToPoint(context, x, y);
			} else {
				CGContextAddLineToPoint(context, x, y);
			}
            CGContextAddLineToPoint(context, x, y + self.frame.size.height);
		}
		
		CGContextStrokePath(context);
	}
}

@end
