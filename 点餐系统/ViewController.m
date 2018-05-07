

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)NSArray *foods;
@property (weak, nonatomic) IBOutlet UILabel *shuiGuo;
@property (weak, nonatomic) IBOutlet UILabel *zhuCai;

@property (weak, nonatomic) IBOutlet UILabel *jiuShui;
@property (weak, nonatomic) IBOutlet UIPickerView *zjpPicker;
- (IBAction)RandomMealBtn:(id)sender;

@end

@implementation ViewController
-(NSArray *)foods{
    if(_foods == nil){
        _foods = [NSArray  arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"01foods.plist" ofType:nil]];
                  
    }
   return _foods;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    //默认选中数据
    for(int i = 0;i < self.foods.count ;i++){
         [self  pickerView:self.zjpPicker didSelectRow:0 inComponent:i];//i对应第几组
    }
}
//随机点餐
- (IBAction)RandomMealBtn:(id)sender {
    //3组都要选中随机再选中
   //1 遍历集合中的所有组
    for(int i = 0; i< self.foods.count;i++){
     NSUInteger count =   [self.foods[i] count]; //第I组里面的所有数据
        //2生成随机数去选中，就是行号
     u_int32_t ranNum =    arc4random_uniform((int)count);
        //获取第I组当前选中的行
    NSInteger selRowNum  =  [self.zjpPicker selectedRowInComponent:i];//第I组选中的行
        //判断随机数和当前选中组行是否一致 否则就重新生成
        while (selRowNum == ranNum) {
            ranNum = arc4random_uniform((int)count);
        }
        //让picker选中数据
        [self.zjpPicker selectRow:ranNum inComponent:i animated:YES];
        //将数据显示到label上
        [self  pickerView:self.zjpPicker didSelectRow:ranNum  inComponent:i];//i对应第几组
        
    }
 
    
   
    
    
}
#pragma mark 代理方法
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *selectFood = self.foods[component][row];
    NSLog(@"%@",selectFood);
    //判断选中组Text
    switch (component) {
        case 0:
            self.shuiGuo.text = selectFood;
            break;
        case 1:
            self.zhuCai.text = selectFood;
            break;
        case 2:
            self.jiuShui.text = selectFood;
            break;
        default:
            break;
    }
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
//    NSArray *comFoods =    self.foods[component];
// NSString *food  =   comFoods[row];
//    return food;
    return self.foods[component][row];//
}
#pragma mark 数据源方法-多少组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.foods.count;
}
#pragma mark 数据源方法-每组的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
 return   [self.foods[component] count];
}

@end
