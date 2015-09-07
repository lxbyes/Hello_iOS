//
//  MasterViewController.m
//  TinyPix
//
//  Created by 赖显波 on 9/1/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "TinyPixDocument.h"

@interface MasterViewController () <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *colorControl;
@property (strong, nonatomic) NSArray *documentFilenames;
@property (strong, nonatomic) TinyPixDocument *chosenDocument;

@property (strong, nonatomic) NSMetadataQuery *query;
@property (strong, nonatomic) NSMutableArray *documentURLs;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
    [self reloadFiles];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger selectedColorIndex = [prefs integerForKey:@"selectedColorIndex"];
    [self setTintColorForIndex:selectedColorIndex];
    [self.colorControl setSelectedSegmentIndex:selectedColorIndex];
}

-(void) insertNewObject {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Filename" message:@"Enter a name for your new Tinpix document." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Create", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}


- (NSURL *)urlForFileName:(NSString *)filename {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *directoryURL = urls[0];
    NSURL *fileURL = [directoryURL URLByAppendingPathComponent:filename];
    return fileURL;
}

/*
- (NSURL *)urlForFileName:(NSString *)filename {
    NSURL *baseURL = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    NSURL *pathURL = [baseURL URLByAppendingPathComponent:@"Documents"];
    NSURL *destinationURL = [pathURL URLByAppendingPathComponent:filename];
    return destinationURL;
}*/

- (void)reloadFiles {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSError *dirError;
    NSArray *files = [fm contentsOfDirectoryAtPath:path error:&dirError];
    
    if (!files) {
        NSLog(@"Error listing files in directory %@: %@", path, dirError);
    }
    
    NSLog(@"found files: %@", files);
    
    files = [files sortedArrayUsingComparator:^NSComparisonResult(id filename1, id filename2) {
        NSDictionary *attr1 = [fm attributesOfItemAtPath:[path stringByAppendingPathComponent:filename1] error:nil];
        NSDictionary *attr2 = [fm attributesOfItemAtPath:[path stringByAppendingPathComponent:filename2] error:nil];
        
        return [attr2[NSFileCreationDate] compare:attr1[NSFileCreationDate]];
    }];
    
    self.documentFilenames = files;
    [self.tableView reloadData];
}
/*
- (void)reloadFiles {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL *cloudURL = [fileManager URLForUbiquityContainerIdentifier:nil];
    NSLog(@"got cloudURL %@", cloudURL);
    
    self.query = [[NSMetadataQuery alloc] init];
    _query.predicate = [NSPredicate predicateWithFormat:@"%K like '*.tinypix'", NSMetadataItemFSNameKey];
    _query.searchScopes = [NSArray arrayWithObject:NSMetadataQueryUbiquitousDocumentsScope];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUbiquitousDocuments:) name:NSMetadataQueryDidFinishGatheringNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUbiquitousDocuments:) name:NSMetadataQueryDidUpdateNotification object:nil];
    
    [_query startQuery];
}*/

- (void)updateUbiquitousDocuments:(NSNotification *)notification {
    self.documentURLs = [NSMutableArray array];
    self.documentFilenames = [NSMutableArray array];
    
    NSLog(@"updateUbiquitousDocuments, results = %@", self.query.results);
    
    NSArray *results = [self.query.results sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSMetadataItem *item1 = obj1;
        NSMetadataItem *item2 = obj2;
        
        return [[item2 valueForAttribute:NSMetadataItemFSCreationDateKey] compare:[item1 valueForAttribute:NSMetadataItemFSCreationDateKey]];
    }];
    
    for (NSMetadataItem *item in results) {
        NSURL *url = [item valueForAttribute:NSMetadataItemURLKey];
        [self.documentURLs addObject:url];
        [(NSMutableArray *)_documentFilenames addObject:[url lastPathComponent]];
    }
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.documentFilenames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FileCell"];
    NSString *path = self.documentFilenames[indexPath.row];
    cell.textLabel.text = path.lastPathComponent.stringByDeletingPathExtension;
    
    return cell;
}

- (IBAction)chooseColor:(id)sender {
    NSInteger selectedColorIndex = [(UISegmentedControl *)sender selectedSegmentIndex];
    [self setTintColorForIndex:selectedColorIndex];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:selectedColorIndex forKey:@"selectedColorIndex"];
    [prefs synchronize];
}

- (void)setTintColorForIndex:(NSInteger)selectedColorIndex {
    switch (selectedColorIndex) {
        case 0:
            self.view.window.tintColor = [UIColor redColor];
            break;
        case 1:
            self.view.window.tintColor = [UIColor colorWithRed:0 green:0.6 blue:0 alpha:1];
            break;
        case 2:
            self.view.window.tintColor = [UIColor blueColor];
            break;
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *filename = [NSString stringWithFormat:@"%@.tinypix", [alertView textFieldAtIndex:0].text];
        
        NSURL *saveURL = [self urlForFileName:filename];
        self.chosenDocument = [[TinyPixDocument alloc] initWithFileURL:saveURL];
        
        [self.chosenDocument saveToURL:saveURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"save OK");
                [self reloadFiles];
                [self performSegueWithIdentifier:@"masterToDetail" sender:self];
            } else {
                NSLog(@"failed to save!");
            }
        }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender == self) {
        UIViewController *destination = segue.destinationViewController;
        if ([destination respondsToSelector:@selector(setDetailItem:)]) {
            [destination setValue:self.chosenDocument forKey:@"detailItem"];
        }
    } else {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *filename = self.documentFilenames[indexPath.row];
        
        NSURL *docURL = [self urlForFileName:filename];
        
        self.chosenDocument = [[TinyPixDocument alloc] initWithFileURL:docURL];
        
        [self.chosenDocument openWithCompletionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"load OK.");
                UIViewController *destination = segue.destinationViewController;
                if ([destination respondsToSelector:@selector(setDetailItem:)]) {
                    [destination setValue:self.chosenDocument forKey:@"detailItem"];
                }
            } else {
                NSLog(@"failed to load!");
            }
        }];
    }
}


@end
