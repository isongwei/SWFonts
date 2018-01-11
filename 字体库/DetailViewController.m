
//
//  DetailViewController.m
//  字体库
//
//  Created by iSongWei on 2017/11/14.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic,weak) IBOutlet UITextField * TF;
@property (nonatomic,weak) IBOutlet UITextView  * TV;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _TF.text = self.Fname;
    
    _TV.font = [UIFont fontWithName:self.Fname size:20];
 
    
    
}


@end
