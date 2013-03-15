//
//  EJHViewController.m
//  EJHDelegateObjectExample
//
//  Created by Erik Hope on 3/15/13.
//  Copyright (c) 2013 ehope. All rights reserved.
//

#import "EJHViewController.h"
#import "EJHDelegateObject.h"
#import <objc/runtime.h>

@interface EJHViewController ()
@property (nonatomic, strong) id alertViewDelegate;
@property (nonatomic, strong) id textFieldDelegate;
@end

@implementation EJHViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    field.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:field];
    self.textFieldDelegate = [EJHDelegateObject delegateObjectForProtocol:@protocol(UITextFieldDelegate)];
    [self.textFieldDelegate addImplementation:^(UITextField*textField){
        NSLog(@"textFieldShouldBecomeFirstResponder");
        return YES;
    }forSelector:@selector(textFieldDidBeginEditing:)];
    field.delegate = self.textFieldDelegate;
    
    if(class_conformsToProtocol([self.textFieldDelegate class], @protocol(UITextFieldDelegate))){
        NSLog(@"self.textFieldDelegate conforms to UITextfieldDelegate");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.alertViewDelegate = [EJHDelegateObject delegateObjectForProtocol:@protocol(UIAlertViewDelegate)];
    [self.alertViewDelegate addImplementation:^(UIAlertView* alertView, NSInteger buttonIndex){
        NSLog(@"%@ dismissed with index %i", alertView, buttonIndex);
    } forSelector:@selector(alertView:didDismissWithButtonIndex:)];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Example" message:@"My delegate is an EJHDelegateObject" delegate:self.alertViewDelegate cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alertView show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
