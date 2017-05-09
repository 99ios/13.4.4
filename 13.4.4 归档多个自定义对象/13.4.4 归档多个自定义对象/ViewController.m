//
//  ViewController.m
//  13.4.4 归档多个自定义对象
//
//  Created by 李维佳 on 2017/4/5.
//  Copyright © 2017年 Liz. All rights reserved.
//

#import "ViewController.h"
#import "ArchiveService.h"
#import "Person.h"
@interface ViewController ()
@property (nonatomic,strong) NSMutableArray *personsArray;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@end

@implementation ViewController

-(NSMutableArray *)personsArray{
    if (_personsArray == nil) {
        //从归档文件中创建，如果文件不存在，则初始化一个空的数组
        _personsArray = [ArchiveService readObjectsFromArchiveFile];
        if (_personsArray == nil) {
            _personsArray = [NSMutableArray array];
        }
    }
    return _personsArray;
}

- (IBAction)writeToFile:(id)sender {
    NSDictionary *dict = @{@"name":self.nameTextField.text,
                           @"age":self.ageTextField.text};
    Person *person = [Person personWithDict:dict];
    [self.personsArray addObject:person];
    if([ArchiveService writeObjectsToArchiveFile:self.personsArray]){
        NSLog(@"归档成功");
    };
}

- (IBAction)readFromFile:(id)sender {
    NSMutableArray *persons = [ArchiveService readObjectsFromArchiveFile];
    for (Person *person in persons) {
        NSLog(@"person name: %@, person age:%@", person.name,person.age);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
