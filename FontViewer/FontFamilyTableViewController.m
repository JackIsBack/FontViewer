//
//  ViewController.m
//
// FontViewer
//
// Copyright (c) 2014 RNo
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "FontFamilyTableViewController.h"
#import "FontNameTableViewController.h"
#import "FontCustomCell.h"

@interface FontFamilyTableViewController ()

@end

@implementation FontFamilyTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // List all fonts on iPhone
    self.familyNames = [[NSMutableArray alloc] initWithArray:[UIFont familyNames]];
    [self.familyNames sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.familyNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"fontCell";
    
    NSString *familyName = [self.familyNames objectAtIndex:indexPath.row];
    
    FontCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.fontName.text = familyName;
    cell.fontName.font = [UIFont fontWithName:familyName size:14.];
    
    return cell;
}

#pragma mark -
#pragma mark Storyboard Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"DETAIL_FONT"])
    {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        FontNameTableViewController *vc = [segue destinationViewController];
        
        NSMutableArray *selectedFontNames = [[NSMutableArray alloc] initWithArray:[UIFont fontNamesForFamilyName:[self.familyNames objectAtIndex:path.row]]];
        [selectedFontNames sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        [vc setFontNames:selectedFontNames];
        [vc setFontFamily:[self.familyNames objectAtIndex:path.row]];
    }
}
@end
