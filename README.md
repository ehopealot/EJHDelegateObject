This little library provides a way to instantiate objects which conform to delegate protocols and to specify the implementations of the delegate methods.



    self.alertViewDelegate = [EJHDelegateObject delegateObjectForProtocol:@protocol(UIAlertViewDelegate)];
    [self.alertViewDelegate addImplementation:^(UIAlertView* alertView, NSInteger buttonIndex){
        NSLog(@"%@ dismissed with index %i", alertView, buttonIndex);
    } forSelector:@selector(alertView:didDismissWithButtonIndex:)];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Example" message:@"My delegate is an EJHDelegateObject" delegate:self.alertViewDelegate cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alertView show];
