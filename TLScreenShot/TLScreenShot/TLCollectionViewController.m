//
//  TLCollectionViewController.m
//  TLScreenShot
//
//  Created by lichuanjun on 2017/8/22.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLCollectionViewController.h"

#define kScreenW  [UIScreen mainScreen].bounds.size.width
#define kScreenH  [UIScreen mainScreen].bounds.size.height

@interface TLCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TLCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CollectionView";
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //列距
    flowLayout.minimumInteritemSpacing = 30;
    //行距
    flowLayout.minimumLineSpacing = 30;
    //item大大小
    flowLayout.itemSize = CGSizeMake((kScreenW-60)/3, (kScreenW-60)/3);
    
    flowLayout.headerReferenceSize = CGSizeMake(0.0f, 0.0f);  //设置head大小
    flowLayout.footerReferenceSize = CGSizeMake(kScreenW, 50.0f);
    
    //初始化
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 24, kScreenW, kScreenH) collectionViewLayout:flowLayout];
    //设置代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //设置背景颜色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //添加视图显示
    [self.view addSubview:self.collectionView];
    
    //注册时用UICollectionViewCell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [button setTitle:@"截屏" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveToFileBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
            cell.backgroundColor = [UIColor orangeColor];
            break;
        case 1:
            cell.backgroundColor = [UIColor purpleColor];
            break;
        case 2:
            cell.backgroundColor = [UIColor cyanColor];
            break;
        default:
            break;
    }
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

# pragma MARK: - 截屏

// 1. 截取制定范围（非长图）
- (UIImage *) screenShotWithSize: (CGSize)size {
    UIImage* image = nil;
    /*
     *UIGraphicsBeginImageContextWithOptions有三个参数
     *size    bitmap上下文的大小，就是生成图片的size
     *opaque  是否不透明，当指定为YES的时候图片的质量会比较好
     *scale   缩放比例，指定为0.0表示使用手机主屏幕的缩放比例
     */
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    //此处我截取的是TableView的header.
    [self.collectionView.layer renderInContext: UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    if (image != nil) {
        return image;
    }else {
        return nil;
    }
}

// 2.截取长图，如TableView，CollectionView
- (UIImage *)screenShot {
    UIImage* image = nil;
    UIGraphicsBeginImageContextWithOptions(self.collectionView.contentSize, YES, 0.0);
    
    //保存tableView当前的偏移量
    CGPoint savedContentOffset = self.collectionView.contentOffset;
    CGRect saveFrame = self.collectionView.frame;
    
    //将tableView的偏移量设置为(0,0)
    self.collectionView.contentOffset = CGPointZero;
    self.collectionView.frame = CGRectMake(0, 0, self.collectionView.contentSize.width, self.collectionView.contentSize.height);
    
    //在当前上下文中渲染出tableView
    [self.collectionView.layer renderInContext: UIGraphicsGetCurrentContext()];
    //截取当前上下文生成Image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    //恢复tableView的偏移量
    self.collectionView.contentOffset = savedContentOffset;
    self.collectionView.frame = saveFrame;
    
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        return image;
    }else {
        return nil;
    }
}

// 3.图片拼接
/**
 图片拼接
 
 @param slaveImage 从图片，拼接在masterImage的下面
 @param masterImage 主图片，生成的图片的宽度为masterImage的宽度
 @return 拼接后的图片
 */
- (UIImage *)addSlaveImage:(UIImage *)slaveImage toMasterImage:(UIImage *)masterImage {
    CGSize size;
    size.width = masterImage.size.width;
    size.height = masterImage.size.height + slaveImage.size.height;
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    
    //Draw masterImage
    [masterImage drawInRect:CGRectMake(0, 0, masterImage.size.width, masterImage.size.height)];
    
    //Draw slaveImage
    [slaveImage drawInRect:CGRectMake(0, masterImage.size.height, masterImage.size.width, slaveImage.size.height)];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return resultImage;
}

//保存到文件按钮事件
- (void)saveToFileBtnTapped {
    NSString *imagePath = [self imageSavedPath:@"image.png"];
    
    UIImage *saveImage = nil;
    //    saveImage = [self screenShotWithSize:CGSizeMake(self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
    saveImage = [self screenShot];
    
    BOOL isSaveSuccess = [self saveToDocument:saveImage withFilePath:imagePath];
    
    if (isSaveSuccess) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"操作结果" message:@"保存图片成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"操作结果" message:@"保存图片失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

//根据图片名将图片保存到ImageFile文件夹中
-(NSString *)imageSavedPath:(NSString *) imageName
{
    //获取Documents文件夹目录
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [path objectAtIndex:0];
    //获取文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //指定新建文件夹路径
    NSString *imageDocPath = [documentPath stringByAppendingPathComponent:@"ImageFile"];
    //创建ImageFile文件夹
    [fileManager createDirectoryAtPath:imageDocPath withIntermediateDirectories:YES attributes:nil error:nil];
    //返回保存图片的路径（图片保存在ImageFile文件夹下）
    NSString * imagePath = [imageDocPath stringByAppendingPathComponent:imageName];
    return imagePath;
}

//将选取的图片保存到目录文件夹下
-(BOOL)saveToDocument:(UIImage *) image withFilePath:(NSString *) filePath
{
    if ((image == nil) || (filePath == nil) || [filePath isEqualToString:@""]) {
        return NO;
    }
    
    @try {
        NSData *imageData = nil;
        //获取文件扩展名
        NSString *extention = [filePath pathExtension];
        if ([extention isEqualToString:@"png"]) {
            //返回PNG格式的图片数据
            imageData = UIImagePNGRepresentation(image);
        }else{
            //返回JPG格式的图片数据，第二个参数为压缩质量：0:best 1:lost
            imageData = UIImageJPEGRepresentation(image, 0);
        }
        if (imageData == nil || [imageData length] <= 0) {
            return NO;
        }
        //将图片写入指定路径
        [imageData writeToFile:filePath atomically:YES];
        return  YES;
    }
    @catch (NSException *exception) {
        NSLog(@"保存图片失败");
    }
    
    return NO;
}

@end
