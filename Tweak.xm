@interface SAUIElementViewController
	- (BOOL)handleLongPress:(id)arg1;
	- (BOOL)handleTap:(id)arg1;
@end

bool shouldOverride = YES;

//Dynamic Island Actions
%hook SAUIElementViewController

	- (BOOL)handleLongPress:(UILongPressGestureRecognizer*)arg1
	{
		BOOL canPerformAction = %orig;
		if (shouldOverride && canPerformAction) {
			shouldOverride = NO;
			[self handleTap:nil];
			return NO;
		}

		shouldOverride = YES;
		return canPerformAction;		
	}

	- (BOOL)handleTap:(UILongPressGestureRecognizer*)arg1
	{
		if (shouldOverride) {
			shouldOverride = NO;
			BOOL wasActionPerformed = [self handleLongPress:nil];
			if (wasActionPerformed)
				return NO;
		}

		shouldOverride = YES;
		return %orig;
	}

%end