//
//  HomeView.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/14.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "HomeView.h"
#import "common.h"
#import "TLHeader.h"
#import "Home.h"
#import <CoreLocation/CoreLocation.h>
#import "AAChartKit.h"

@interface HomeView () <UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate> {
    NSArray *listCellHeight;
    int t;

    UIView *totolView;
    UIView *powerView;
    UIView *deviceView;
    UIView *alertView;
    UIView *energyView;
    UIView *contributeView;
    UIView *weatherView;

    CLLocationManager *_locationManager;

    UIButton *btnDay;
    UIButton *btnMonth;
    UIButton *btnYear;
    UIImageView *imgAL;
    UIImageView *imgRL;

    UIImageView *imgTotol;
    UIImageView *imgLAround;
    UIImageView *imgRAround;

    UIButton *btnChoose;

    CABasicAnimation *rotationAnimation;

    HomeViewModel *model;

    int isFirstTime;
    
    int timeType;
    NSString *time;
    NSString *uniqueId;
    AAChartView *aaChartView;
    AAChartModel *chartModel;
}

/** 出生年月 */
@property (nonatomic, strong) BRTextField *birthdayTF;

@property (nonatomic , strong) NSString *city;

@end


@implementation HomeView

#pragma mark - 表单

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
        if (!model)
        {
            model = [[HomeViewModel alloc] init];
        }
        model.city = @"获取位置失败";
        model.weather = @"未获取到天气数据";
        model.temp1 = @"0";
        model.temp2 = @"0";
        model.wind = @"";
        model.windD = @"无风速数据";
        model.Tree = @"0";
        model.CO2 = @"0";
        model.Coal = @"0";
        model.ele_out = @"0";
        model.ele_cost = @"0";
        model.ele_earnings = @"0";
        model.ele_in = @"0";
        model.ele_out_total = @"0";
        model.photovoltaicRuntimePower = @"0";
        model.photovoltaicTheroyPower = @"1000";
        
        self->model.photovoltaic_y = [NSMutableArray new];
        self->model.charger_y = [NSMutableArray new];
        self->model.grid_y = [NSMutableArray new];
        self->model.cost_y = [NSMutableArray new];
        
        self->model.photovoltaic_x = [NSMutableArray new];
        self->model.charger_x = [NSMutableArray new];
        self->model.grid_x = [NSMutableArray new];
        self->model.cost_x = [NSMutableArray new];

        isFirstTime = 0;
        timeType = 3;
        time = [self getData];
        uniqueId = [[NSUserDefaults standardUserDefaults] objectForKey:UNIQUEID];
        if (!uniqueId) {
            uniqueId = @"";
        }
        
        [self getLocationData];

        [self getTotolData];
        [self getContribute];

        [self getEnergyTendencyWithUniqueId:uniqueId andTimeType:timeType andTime:[time substringToIndex:4]];
        

        [self getView];
    }
    return self;
}

- (NSString *)getData{
    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyyMMdd"];
    return [format1 stringFromDate:date];
}

/**
 * 加载视图
 */
- (void)getView
{

    [self loadTotolView];
    [self loadPowerView];
    [self loadDeviceView];
    [self loadAlertView];
    [self loadEnergyView];
    [self loadContributeView];
    [self loadWeatherView];

    [self pretreatment];




    // 1.5s后自动调用self的hideHUD方法
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(tableViewReload) userInfo:nil repeats:NO];
    // repeats如果为YES，意味着每隔1.5s都会调用一次self的hidHUD方法
}

- (void)tableViewReload{
    [self.tableView reloadData];
}


- (void)getLocationData{
    // 初始化定位管理器

    _locationManager = [[CLLocationManager alloc] init];

    // 设置代理

    _locationManager.delegate = self;

    // 设置定位精确度到米

    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    // 设置过滤器为无

    _locationManager.distanceFilter = kCLDistanceFilterNone;

    // 开始定位

    // 取得定位权限，有两个方法，取决于你的定位使用情况

    // 一个是requestAlwaysAuthorization，一个是requestWhenInUseAuthorization

    [_locationManager requestAlwaysAuthorization];//这句话ios8以上版本使用。

    [_locationManager startUpdatingLocation];
}



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{

    //将经度显示到label上

    [NSString stringWithFormat:@"%lf", [newLocation coordinate].latitude];

    //将纬度现实到label上

    [NSString stringWithFormat:@"%lf", [newLocation coordinate].longitude];

    // 获取当前所在的城市名

    CLGeocoder *geocoder = [[CLGeocoder alloc] init];

    //根据经纬度反向地理编译出地址信息

    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error)
    {

        if (array.count > 0)
        {
            [manager stopUpdatingLocation];
            CLPlacemark *placemark = array.firstObject;
            //将获得的所有信息显示到label上

            //self.location.text = placemark.name;

            //获取城市

            NSString *city = placemark.locality;

            if (!city)
            {

                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）

                city = placemark.administrativeArea;

            }

            dispatch_async(dispatch_get_main_queue(), ^{

                NSLog(@"city = %@", city);
                if (self->isFirstTime == 0) {
                    if (city) {
                        if (city.length > 0) {
                            self->isFirstTime = 1;
                            
                            [Home getAllArea:^(id data) {
                                
                                NSArray *arr = data;
                                NSString *adCode;
                                
                                for (NSDictionary *d in arr) {
                                    NSString *name = d[@"name"];
                                    NSArray *citys = d[@"citys"];
                                    if([name isEqualToString:city]) {
                                        adCode = d[@"adCode"];
                                        break;
                                    }
                                    if (citys == nil || [citys count] == 0) continue;
                                    for (NSDictionary *d1 in citys) {
                                        name = d1[@"name"];
                                        NSArray *areas = d1[@"areas"];
                                        if([name isEqualToString:city]) {
                                            adCode = d1[@"adCode"];
                                            break ;
                                        }
                                        if (areas == nil || [areas count] == 0) continue;
                                        for (NSDictionary *d2 in areas) {
                                            name = d2[@"name"];
                                            if([name isEqualToString:city]) {
                                                adCode = d2[@"adCode"];
                                                break ;
                                            }
                                        }
                                        if (adCode != nil) {
                                            break;
                                        }
                                    }
                                    if (adCode != nil) {
                                        break;
                                    }
                                }
                                
                                [Home getWeather:@{@"adCode": adCode} Success:^(id data1) {
                                    NSDictionary *dic = data1;
                                    self->model.weather = dic[@"data"][@"weather"];
                                    self->model.wind = dic[@"data"][@"windpower"];
                                    self->model.windD = dic[@"data"][@"winddirection"];
                                    self->model.temp1 =  dic[@"data"][@"temperature"];
                            
                                    self->model.city = city;
                                    NSLog(@"model.city = %@", self->model.city);
                                    [manager stopUpdatingLocation];
                                    
                                }];
                                
                            }];
                            
                            

                        }
                    }
                }
            });

        }

        else if (error == nil && [array count] == 0)

        {
            NSLog(@"No results were returned.");
        }



        else if (error != nil)

        {
            NSLog(@"An error occurred = %@", error);

        }

        NSLog(@"city = %@",self.city);

    }];

}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied)
    {

        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在

        if (!model)
        {
            model.city = @"定位失败";
        }
    }
}

#pragma mark - 获取数据
/**
 获取累计数据
 */
- (void)getTotolData{
    [Home getHome:@{@"uniqueId":uniqueId} Success:^(id  _Nonnull data) {
        NSLog(@"home = %@",data);
        NSDictionary *dic0 = data;
        model.ele_out_total = data[@"data"][@"ele_out_total"];
        model.ele_out = data[@"data"][@"ele_out"];
        model.ele_cost = data[@"data"][@"ele_cost"];
        model.ele_earnings = data[@"data"][@"ele_earnings"];
        model.ele_in = data[@"data"][@"ele_in"];

        model.aircondition = data[@"data"][@"devsData"][@"aircondition"];
        model.ameter = data[@"data"][@"devsData"][@"ameter"];
        model.inverter = data[@"data"][@"devsData"][@"inverter"];
        model.socket = data[@"data"][@"devsData"][@"socket"];
        model.thermostat = data[@"data"][@"devsData"][@"thermostat"];

        model.photovoltaicRuntimePower = data[@"data"][@"photovoltaicRuntimePower"];
        model.photovoltaicTheroyPower = data[@"data"][@"photovoltaicTheroyPower"];
        model.gridPower = data[@"data"][@"gridPower"];
        model.storageSystem = data[@"data"][@"storageSystem"];
    }];
    [self.tableView reloadData];
}


/**
 获取能源趋势
 */
- (void)getEnergyTendencyWithUniqueId:(NSString *)uniqueId andTimeType:(int)timeType andTime:(NSString *)time{
    [Home getEnergyTendency:@{@"uniqueId":uniqueId,@"timeType":[NSNumber numberWithInt:timeType],@"time":time}
                    Success:^(id  _Nonnull data)
    {
        //NSLog(@"EnergyTendency = %@",data);
        
        NSArray *charger = data[@"data"][@"charger"];
        NSArray *cost = data[@"data"][@"cost"];
        NSArray *grid = data[@"data"][@"grid"];
        NSArray *photovoltaic = data[@"data"][@"photovoltaic"];
        
        [self separateWithArray:photovoltaic andArray_x:self->model.photovoltaic_x andArray_y:self->model.photovoltaic_y];
        [self separateWithArray:charger andArray_x:self->model.charger_x andArray_y:self->model.charger_y];
        [self separateWithArray:grid andArray_x:self->model.grid_x andArray_y:self->model.grid_y];
        [self separateWithArray:cost andArray_x:self->model.cost_x andArray_y:self->model.cost_y];
        
        [self->aaChartView aa_refreshChartWithChartModel:self->chartModel];
        
    }];
}

/**
 分离x轴和y轴的数据
 */
- (void)separateWithArray:(NSArray *)array andArray_x:(NSMutableArray *)array_x andArray_y:(NSMutableArray *)array_y{
    [array_x removeAllObjects];
    [array_y removeAllObjects];
    //if (array == nil) return;
    //if ([array count] == 0	) return;
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    if(timeType == 4){
        NSNumber *year = [f numberFromString:[time substringToIndex:4]];
        int a = [year intValue];
        for (int i = a - 5; i <= a; i++) {
            [array_x addObject:[NSNumber numberWithInteger:i]];
            for(NSDictionary *d in array){
                NSNumber *num = d[@"ctime"];
                if ([num intValue] == i) {
                    [array_y addObject:d[@"ele"]];
                }
            }
        }
    }else{
        for(NSDictionary *d in array){
            NSString *time = d[@"ctime"];
            [array_x addObject:[time substringFromIndex:[time length]-2]];
            [array_y addObject:d[@"ele"]];
        }
    }
}

/**
 获取贡献数据
 */
- (void)getContribute{
    NSLog(@"uniqueID = %@", [[NSUserDefaults standardUserDefaults] stringForKey:UNIQUEID]);

        [Home getGreenBenifit:@{@"uniqueId":uniqueId} Success:^(id data) {
//            NSLog(@"benifit = %@",data);
            NSDictionary *dic0 = data;
            NSLog(@"dic0 = %@",data);
            model.CO2 = [NSString stringWithFormat:@"%@",dic0[@"data"][@"CO2"]];
            model.Coal = [NSString stringWithFormat:@"%@",dic0[@"data"][@"TCE"]];
            model.Tree = [NSString stringWithFormat:@"%@",dic0[@"data"][@"plants"]];
            [self.tableView reloadData];
        }];
    
    [self.tableView reloadData];
}


#pragma mark - 加载视图
- (void)pretreatment{
    t = -1;

    if (!self.tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.bounces = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor clearColor];
    }
    listCellHeight = @[@"338",@"360",@"190",@"80",@"300",@"180",@"100"];

    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @((float) (M_PI * 2.0));
    rotationAnimation.duration = 4;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1;

    [self addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listCellHeight.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.000000001)];
    headView.backgroundColor = [UIColor colorWithRed:(CGFloat) (156 / 255.0) green:137255.0 blue:124255.0 alpha:0.2];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.0000001)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    for (int i = 0; i<listCellHeight.count; i++) {
        if (indexPath.row == i) {
            return (CGFloat) ([listCellHeight[(NSUInteger) i] floatValue] *ProportionX);
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];

    if (indexPath.row == 0) {

        if (totolView) {
            [totolView removeFromSuperview];
            [self loadTotolView];
            [cell addSubview:totolView];
        }

        return cell;
    } else {
        UIImageView *cellBG = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, (CGFloat) (50*ProportionX))];
        cellBG.backgroundColor = [UIColor colorWithRed:0 green:(CGFloat) (31 / 255.0) blue:(CGFloat) (40 / 255.0) alpha:0.8];
        cellBG.layer.masksToBounds = YES;
        cellBG.layer.cornerRadius = 10;
        [cell addSubview:cellBG];

        UIImageView *cellFrame = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 10)];
        cellFrame.image = [UIImage imageNamed:@"高光"];
        [cell addSubview:cellFrame];
        for (int i = 1; i < listCellHeight.count; i++) {
            if (indexPath.row == i) {
                cellBG.frame = CGRectMake(10, 0, self.frame.size.width - 20, (CGFloat) ([listCellHeight[i] floatValue]*ProportionX -10));
            }
        }

        if (indexPath.row == 1) {

            if (powerView) {
                [powerView removeFromSuperview];
                [self loadPowerView];
                [cell addSubview:powerView];
            }

//            [cell addSubview:powerView];

        } else if (indexPath.row == 2) {

            if (deviceView) {
                [deviceView removeFromSuperview];
                [self loadDeviceView];
                [cell addSubview:deviceView];
            }
        } else if (indexPath.row == 3) {

            [cell addSubview:alertView];
        } else if (indexPath.row == 4) {

            [cell addSubview:energyView];
        } else if (indexPath.row == 5) {

            if (contributeView) {
                [contributeView removeFromSuperview];
                [self loadContributeView];
                [cell addSubview:contributeView];
            }
            [cell addSubview:contributeView];
        } else if (indexPath.row == 6) {
            if (weatherView) {
                [weatherView removeFromSuperview];
                [self loadWeatherView];
                [cell addSubview:weatherView];
            }
            if (t == -1)
            {
                t = 0;
                [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeImageHome) userInfo:nil repeats:YES];
                [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(RotaAnimate) userInfo:nil repeats:YES];
            }
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
            [self.customDelegate btnClickWithTag:@"Alert"];
        }
    }
}


#pragma mark - 视图

/**
 累计发电视图
 */
- (void)loadTotolView{
    totolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, (CGFloat) (804/2.0 - 64))];

    imgTotol = [[UIImageView alloc] initWithFrame:CGRectMake((CGFloat) ((self.frame.size.width - 217*ProportionX)/2), 0, (CGFloat) (217*ProportionX), (CGFloat) (217*ProportionX))];
    imgTotol.image = [UIImage imageNamed:@"总发电_bg"];
    [totolView addSubview:imgTotol];

    [imgTotol.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];//开始动画

    CFGradientLabel *lblDataTotol;
    lblDataTotol = [CFGradientLabel addGradientLabelWithFrame:imgTotol.center
                                                 gradientText:[NSString stringWithFormat:@"%@",model.ele_out_total]
                                                     infoText:[NSString stringWithFormat:@"%@",model.ele_out_total]
                                                       colors:@[(id) RGB_HEX(0x00c0ff, 1).CGColor, (id) RGB_HEX(0x08ffce, 1).CGColor]
                                                         font:[UIFont systemFontOfSize:(CGFloat) (35 * ProportionX)]];

    [totolView addSubview:lblDataTotol];

    UILabel *lblTotol = [[UILabel alloc] initWithFrame:CGRectMake(0, (CGFloat) (lblDataTotol.frame.origin.y - 30*ProportionX), self.frame.size.width, (CGFloat) (30*ProportionX))];
    lblTotol.textColor = [UIColor whiteColor];
    lblTotol.text = @"累计发电";
    lblTotol.textAlignment = NSTextAlignmentCenter;
    lblTotol.font = FontL;
    [totolView addSubview:lblTotol];

    UILabel *lblUnit = [[UILabel alloc] initWithFrame:CGRectMake(0, lblDataTotol.frame.origin.y + lblDataTotol.frame.size.height, self.frame.size.width, (CGFloat) (30*ProportionX))];
    lblUnit.textColor = [UIColor whiteColor];
    lblUnit.text = @"Mwh";
    lblUnit.textAlignment = NSTextAlignmentCenter;
    lblUnit.font = FontL;
    [totolView addSubview:lblUnit];

    float width = (float) (45*ProportionX);
    float height = width;
    float width1 = (float) ((self.frame.size.width - 20) / 4.0);
    float height1 = (float) (30*ProportionX);
    float gap = (float) ((width1 - width)/2.0);

    UIButton *btnMonthEnergy = [[UIButton alloc] initWithFrame:CGRectMake(gap + 10 + width1 * 0, (CGFloat) (220*ProportionX), width, height)];
    [btnMonthEnergy setBackgroundImage:[UIImage imageNamed:@"当月发电"] forState:UIControlStateNormal];
    [totolView addSubview:btnMonthEnergy];

    UIButton *btnMonthPrice = [[UIButton alloc] initWithFrame:CGRectMake(gap + 10 + width1 * 1, (CGFloat) (220*ProportionX), width, height)];
    [btnMonthPrice setBackgroundImage:[UIImage imageNamed:@"当月电费"] forState:UIControlStateNormal];
    [totolView addSubview:btnMonthPrice];

    UIButton *btnMonthGain = [[UIButton alloc] initWithFrame:CGRectMake(gap + 10 + width1 * 2, (CGFloat) (220*ProportionX), width, height)];
    [btnMonthGain setBackgroundImage:[UIImage imageNamed:@"当月收益"] forState:UIControlStateNormal];
    [totolView addSubview:btnMonthGain];

    UIButton *btnMonthCoast = [[UIButton alloc] initWithFrame:CGRectMake(gap + 10 + width1 * 3, (CGFloat) (220*ProportionX), width, height)];
    [btnMonthCoast setBackgroundImage:[UIImage imageNamed:@"当月用电"] forState:UIControlStateNormal];
    [totolView addSubview:btnMonthCoast];

    UILabel *lblDataMonthEnergy = [[UILabel alloc] initWithFrame:CGRectMake(10 + width1 * 0, (CGFloat) (220*ProportionX + width + 7*ProportionX), width1, height1)];

    lblDataMonthEnergy.attributedText = [stringColor String: [NSString stringWithFormat:@"%@kWh",model.ele_out]
                                                StringColor:[UIColor whiteColor]
                                                 StringFont:FontL
                                                        str:@"kWh"
                                                      color:[UIColor whiteColor]
                                                       font:[UIFont systemFontOfSize:14]
                                                aligentment:NSTextAlignmentCenter];

    [totolView addSubview:lblDataMonthEnergy];

    UILabel *lblMonthEnergy = [[UILabel alloc] initWithFrame:CGRectMake(10 + width1 * 0, (CGFloat) (220*ProportionX + width +7*ProportionX + height1), width1, height1)];
    lblMonthEnergy.textAlignment = NSTextAlignmentCenter;
    lblMonthEnergy.font = FontM;
    lblMonthEnergy.textColor = [UIColor colorWithRed:(CGFloat) (93 / 255.0) green:(CGFloat) (199 / 255.0) blue:(CGFloat) (247 / 255.0) alpha:1];
    lblMonthEnergy.text = @"当月发电";
    [totolView addSubview:lblMonthEnergy];

    UILabel *lblDataMonthPrice = [[UILabel alloc] initWithFrame:CGRectMake(10 + width1 * 1, (CGFloat) (220*ProportionX + width + 7*ProportionX), width1, height1)];

    lblDataMonthPrice.attributedText = [stringColor String: [NSString stringWithFormat:@"￥%@",model.ele_cost]
                                               StringColor:[UIColor whiteColor]
                                                StringFont:FontL
                                                       str:@"￥"
                                                     color:[UIColor whiteColor]
                                                      font:[UIFont systemFontOfSize:14]
                                               aligentment:NSTextAlignmentCenter];

    [totolView addSubview:lblDataMonthPrice];

    UILabel *lblMonthPrince = [[UILabel alloc] initWithFrame:CGRectMake(10 + width1 * 1, (CGFloat) (220*ProportionX + width +7*ProportionX + height1), width1, height1)];
    lblMonthPrince.textAlignment = NSTextAlignmentCenter;
    lblMonthPrince.font = FontM;
    lblMonthPrince.textColor = [UIColor colorWithRed:(CGFloat) (93 / 255.0) green:(CGFloat) (199 / 255.0) blue:(CGFloat) (247 / 255.0) alpha:1];
    lblMonthPrince.text = @"当月电费";
    [totolView addSubview:lblMonthPrince];

    UILabel *lblDataMonthGain = [[UILabel alloc] initWithFrame:CGRectMake(10 + width1 * 2, (CGFloat) (220*ProportionX + width + 7*ProportionX), width1, height1)];

    lblDataMonthGain.attributedText = [stringColor String: [NSString stringWithFormat:@"￥%@",model.ele_earnings]
                                              StringColor:[UIColor whiteColor]
                                               StringFont:FontL
                                                      str:@"￥"
                                                    color:[UIColor whiteColor]
                                                     font:[UIFont systemFontOfSize:14]
                                              aligentment:NSTextAlignmentCenter];

    [totolView addSubview:lblDataMonthGain];

    UILabel *lblMonthGain = [[UILabel alloc] initWithFrame:CGRectMake(10 + width1 * 2, (CGFloat) (220*ProportionX + width +7*ProportionX + height1), width1, height1)];
    lblMonthGain.textAlignment = NSTextAlignmentCenter;
    lblMonthGain.font = FontM;
    lblMonthGain.textColor = [UIColor colorWithRed:(CGFloat) (93 / 255.0) green:(CGFloat) (199 / 255.0) blue:(CGFloat) (247 / 255.0) alpha:1];
    lblMonthGain.text = @"当月收益";
    [totolView addSubview:lblMonthGain];

    UILabel *lblDataMonthCoast = [[UILabel alloc] initWithFrame:CGRectMake(10 + width1 * 3, (CGFloat) (220*ProportionX + width + 7*ProportionX), width1, height1)];

    lblDataMonthCoast.attributedText = [stringColor String: [NSString stringWithFormat:@"%@kWh",model.ele_in]
                                               StringColor:[UIColor whiteColor]
                                                StringFont:FontL
                                                       str:@"kWh"
                                                     color:[UIColor whiteColor]
                                                      font:[UIFont systemFontOfSize:14]
                                               aligentment:NSTextAlignmentCenter];

    [totolView addSubview:lblDataMonthCoast];

    UILabel *lblMonthCoast = [[UILabel alloc] initWithFrame:CGRectMake(10 + width1 * 3, (CGFloat) (220*ProportionX + width +7*ProportionX + height1), width1, height1)];
    lblMonthCoast.textAlignment = NSTextAlignmentCenter;
    lblMonthCoast.font = FontM;
    lblMonthCoast.textColor = [UIColor colorWithRed:(CGFloat) (93 / 255.0) green:(CGFloat) (199 / 255.0) blue:(CGFloat) (247 / 255.0) alpha:1];
    lblMonthCoast.text = @"当月用电";
    [totolView addSubview:lblMonthCoast];
}



/**
 系统功率视图
 */
- (void)loadPowerView{
    powerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, (CGFloat) (604/2.0))];

    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, (CGFloat) (45*ProportionX))];
    lblTitle.font = FontTitle;
    lblTitle.text = @"系统功率";
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [powerView addSubview:lblTitle];

    ProgressView *progressView0 = [[ProgressView alloc] initWithFrame:CGRectMake((CGFloat) (60*ProportionX), (CGFloat) (45*ProportionX), (CGFloat) (60*ProportionX), 60*ProportionX)];
    progressView0.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    progressView0.colorTop = [UIColor colorWithRed:(CGFloat) (94 / 255.0) green:(CGFloat) (174 / 255.0) blue:(CGFloat) (255 / 255.0) alpha:1];

    float photovoltaicRuntimePower = [model.photovoltaicRuntimePower floatValue];
    float photovoltaicTheroyPower = [model.photovoltaicTheroyPower floatValue];
    NSLog(@"%f , %f",photovoltaicRuntimePower,photovoltaicTheroyPower);

    progressView0.progress = (CGFloat) (photovoltaicRuntimePower/photovoltaicTheroyPower);
    progressView0.colorButtom = [UIColor colorWithRed:(CGFloat) (4 / 255.0) green:(CGFloat) (67 / 255.0) blue:(CGFloat) (175 / 255.0) alpha:1];
    progressView0.animationTime = 1;
    progressView0.topWidth = (float) (5*ProportionX);
    progressView0.buttomWidth = (float) (5*ProportionX);
    [powerView addSubview:progressView0];

    UILabel *progress0 = [[UILabel alloc] initWithFrame:CGRectMake(progressView0.frame.origin.x, progressView0.frame.origin.y, progressView0.frame.size.width, progressView0.frame.size.height)];
    progress0.textAlignment= NSTextAlignmentCenter;
    progress0.textColor = [UIColor whiteColor];
    progress0.text = [NSString stringWithFormat:@"%.0f%%",progressView0.progress*100];
    [powerView addSubview:progress0];

    UIImageView *img00 = [[UIImageView alloc] initWithFrame:CGRectMake((CGFloat) (15*ProportionX), (CGFloat) (130*ProportionX), (CGFloat) (10*ProportionX), (CGFloat) (10*ProportionX))];
    img00.backgroundColor = [UIColor colorWithRed:62/255.0 green:151/255.0 blue:1 alpha:1];
    img00.layer.masksToBounds = YES;
    img00.layer.cornerRadius = (CGFloat) (5*ProportionX);
    [powerView addSubview:img00];

    UILabel *lbl00 = [[UILabel alloc] initWithFrame:CGRectMake((CGFloat) (30*ProportionX), (CGFloat) (120*ProportionX), (CGFloat) (100*ProportionX), (CGFloat) (30*ProportionX))];
    lbl00.textColor = [UIColor colorWithRed:(CGFloat) (85 / 255.0) green:(CGFloat) (185 / 255.0) blue:(CGFloat) (230 / 255.0) alpha:1];
    lbl00.textAlignment = NSTextAlignmentLeft;
    lbl00.text = @"运行容量";
    lbl00.font = FontM;
    [powerView addSubview:lbl00];

    UILabel *lblData00 = [[UILabel alloc] initWithFrame:CGRectMake((CGFloat) (105*ProportionX), (CGFloat) (120*ProportionX), (CGFloat) (100*ProportionX), (CGFloat) (30*ProportionX))];
    lblData00.textAlignment = NSTextAlignmentLeft;
    lblData00.textColor = [UIColor whiteColor];
    lblData00.text = [NSString stringWithFormat:@"%@ W",model.photovoltaicRuntimePower];
    lblData00.font = FontM;
    [powerView addSubview:lblData00];

    UIImageView *img01 = [[UIImageView alloc] initWithFrame:CGRectMake((CGFloat) (15*ProportionX), (CGFloat) (130*ProportionX +30*ProportionX), (CGFloat) (10*ProportionX), (CGFloat) (10*ProportionX))];
    img01.backgroundColor = [UIColor colorWithRed:(CGFloat) (4 / 255.0) green:(CGFloat) (67 / 255.0) blue:(CGFloat) (175 / 255.0) alpha:1];
    img01.layer.masksToBounds = YES;
    img01.layer.cornerRadius = (CGFloat) (5*ProportionX);
    [powerView addSubview:img01];

    UILabel *lbl01 = [[UILabel alloc] initWithFrame:CGRectMake((CGFloat) (30*ProportionX), (CGFloat) (120*ProportionX+30*ProportionX), (CGFloat) (100*ProportionX), (CGFloat) (30*ProportionX))];
    lbl01.textColor = [UIColor colorWithRed:(CGFloat) (85 / 255.0) green:(CGFloat) (185 / 255.0) blue:(CGFloat) (230 / 255.0) alpha:1];
    lbl01.textAlignment = NSTextAlignmentLeft;
    lbl01.text = @"装机容量";
    lbl01.font = FontM;
    [powerView addSubview:lbl01];

    UILabel * lblData01 = [[UILabel alloc] initWithFrame:CGRectMake((CGFloat) (105*ProportionX), (CGFloat) (120*ProportionX+30*ProportionX), (CGFloat) (100*ProportionX), (CGFloat) (30*ProportionX))];
    lblData01.textAlignment = NSTextAlignmentLeft;
    lblData01.textColor = [UIColor whiteColor];
    lblData01.text = [NSString stringWithFormat:@"%@ W",model.photovoltaicTheroyPower];
    lblData01.font = FontM;
    [powerView addSubview:lblData01];



    ProgressView *progressView1 = [[ProgressView alloc] initWithFrame:CGRectMake(self.frame.size.width - 60*ProportionX - 60*ProportionX, 45*ProportionX , 60*ProportionX, 60*ProportionX)];
    progressView1.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    progressView1.colorTop = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:168/255.0 alpha:1];
    progressView1.progress = 22.124/52.124;
    progressView1.colorButtom = [UIColor colorWithRed:0/255.0 green:135/255.0 blue:89/255.0 alpha:1];
    progressView1.animationTime = 1;
    progressView1.topWidth = 5*ProportionX;
    progressView1.buttomWidth = 5*ProportionX;
    [powerView addSubview:progressView1];

    UILabel *progress1 = [[UILabel alloc] initWithFrame:CGRectMake(progressView1.frame.origin.x, progressView1.frame.origin.y, progressView1.frame.size.width, progressView1.frame.size.height)];
    progress1.textAlignment= NSTextAlignmentCenter;
    progress1.textColor = [UIColor whiteColor];
    progress1.text = [NSString stringWithFormat:@"%.0f%%",progressView1.progress*100];
    [powerView addSubview:progress1];

    UIImageView *img10 = [[UIImageView alloc] initWithFrame:CGRectMake(15*ProportionX+ self.frame.size.width/2.0, 130*ProportionX, 10*ProportionX, 10*ProportionX)];
    img10.backgroundColor = [UIColor colorWithRed:17/255.0 green:214/255.0 blue:147/255.0 alpha:1];
    img10.layer.masksToBounds = YES;
    img10.layer.cornerRadius = 5*ProportionX;
    [powerView addSubview:img10];

    UILabel *lbl10 = [[UILabel alloc] initWithFrame:CGRectMake(30*ProportionX + self.frame.size.width/2.0, 120*ProportionX, 100*ProportionX, 30*ProportionX)];
    lbl10.textColor = [UIColor colorWithRed:85/255.0 green:185/255.0 blue:230/255.0 alpha:1];
    lbl10.textAlignment = NSTextAlignmentLeft;
    lbl10.text = @"发电功率";
    lbl10.font = FontM;
    [powerView addSubview:lbl10];

    UILabel *lblData10 = [[UILabel alloc] initWithFrame:CGRectMake(105*ProportionX+ self.frame.size.width/2.0, 120*ProportionX, 100*ProportionX, 30*ProportionX)];
    lblData10.textAlignment = NSTextAlignmentLeft;
    lblData10.textColor = [UIColor whiteColor];
    lblData10.text = @"22.124 W";
    lblData10.font = FontM;
    [powerView addSubview:lblData10];

    UIImageView *img11 = [[UIImageView alloc] initWithFrame:CGRectMake(15*ProportionX+ self.frame.size.width/2.0, 130*ProportionX +30*ProportionX, 10*ProportionX, 10*ProportionX)];
    img11.backgroundColor = [UIColor colorWithRed:0/255.0 green:135/255.0 blue:89/255.0 alpha:1];
    img11.layer.masksToBounds = YES;
    img11.layer.cornerRadius = 5*ProportionX;
    [powerView addSubview:img11];

    UILabel *lbl11 = [[UILabel alloc] initWithFrame:CGRectMake(30*ProportionX+ self.frame.size.width/2.0, 120*ProportionX+30*ProportionX, 100*ProportionX, 30*ProportionX)];
    lbl11.textColor = [UIColor colorWithRed:85/255.0 green:185/255.0 blue:230/255.0 alpha:1];
    lbl11.textAlignment = NSTextAlignmentLeft;
    lbl11.text = @"总功率";
    lbl11.font = FontM;
    [powerView addSubview:lbl11];

    UILabel * lblData11 = [[UILabel alloc] initWithFrame:CGRectMake(105*ProportionX+ self.frame.size.width/2.0, 120*ProportionX+30*ProportionX, 100*ProportionX, 30*ProportionX)];
    lblData11.textAlignment = NSTextAlignmentLeft;
    lblData11.textColor = [UIColor whiteColor];
    lblData11.text = @"52.124 W";
    lblData11.font = FontM;
    [powerView addSubview:lblData11];

    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 190*ProportionX, self.frame.size.width - 20*ProportionX, 1)];
    lblLine.backgroundColor = [UIColor colorWithRed:28/255.0 green:57/255.0 blue:66/255.0 alpha:1];
    [powerView addSubview:lblLine];

    imgLAround = [[UIImageView alloc] initWithFrame:CGRectMake(30*ProportionX, 17*ProportionX+190*ProportionX, 58*ProportionX, 58*ProportionX)];
    imgLAround.image = [UIImage imageNamed:@"光伏功率_around"];
    [powerView addSubview:imgLAround];


    [imgLAround.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];//开始动画

    UIImageView *imgL = [[UIImageView alloc] initWithFrame:CGRectMake(34*ProportionX, 21*ProportionX+190*ProportionX, 50*ProportionX, 50*ProportionX)];
    imgL.image = [UIImage imageNamed:@"光伏功率_work"];
    [powerView addSubview:imgL];


    imgAL = [[UIImageView alloc] initWithFrame:CGRectMake(90*ProportionX, 39*ProportionX + 190*ProportionX, 54*ProportionX, 16.5*ProportionX)];
    imgAL.image = [UIImage imageNamed:@"光伏功率_流动_work1"];
    [powerView addSubview:imgAL];

    imgRAround = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 38*ProportionX - 50*ProportionX, 17*ProportionX+190*ProportionX, 58*ProportionX, 58*ProportionX)];
    imgRAround.image = [UIImage imageNamed:@"电网功率_around"];
    [powerView addSubview:imgRAround];
    [imgRAround.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];//开始动画

    UIImageView *imgR = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 34*ProportionX - 50*ProportionX, 21*ProportionX+190*ProportionX, 50*ProportionX, 50*ProportionX)];
    imgR.image = [UIImage imageNamed:@"电网功率_work"];
    [powerView addSubview:imgR];

    imgRL = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 90*ProportionX - 54*ProportionX, 39*ProportionX + 190*ProportionX, 54*ProportionX, 16.5*ProportionX)];
    imgRL.image = [UIImage imageNamed:@"电网功率_流动_work1"];
    [powerView addSubview:imgRL];

    ProgressView *progressViewC = [[ProgressView alloc] initWithFrame:CGRectMake((self.frame.size.width - 70*ProportionX)/2.0, 11*ProportionX+190*ProportionX, 70*ProportionX, 70*ProportionX)];
    progressViewC.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    progressViewC.colorTop = [UIColor colorWithRed:255/255.0 green:193/255.0 blue:0/255.0 alpha:1];
    progressViewC.progress = 200/1000;
    progressViewC.colorButtom = [UIColor colorWithRed:6/255.0 green:255/255.0 blue:94/255.0 alpha:1];
    progressViewC.animationTime = 1;
    progressViewC.topWidth = 5*ProportionX;
    progressViewC.buttomWidth = 5*ProportionX;
    [powerView addSubview:progressViewC];

    UIImageView *imgC = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 50*ProportionX)/2.0, 21*ProportionX+190*ProportionX, 50*ProportionX, 50*ProportionX)];
    imgC.image = [UIImage imageNamed:@"负载功率_bg"];
    [powerView addSubview:imgC];

    [imgC.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];//开始动画

    float gap = 10;
    float width = (self.frame.size.width - 20)/3.0;

    UILabel *lblPowerPhotovoltaic = [[UILabel alloc] initWithFrame:CGRectMake(30*ProportionX, 11*ProportionX+190*ProportionX+80*ProportionX, 58*ProportionX, 30*ProportionX)];

    lblPowerPhotovoltaic.attributedText = [stringColor String:@"800W"
                                                  StringColor:[UIColor colorWithRed:6/255.0 green:254/255.0 blue:94/255.0 alpha:1]
                                                   StringFont:FontL
                                                          str:@"W"
                                                        color:[UIColor whiteColor]
                                                         font:FontS
                                                  aligentment:NSTextAlignmentCenter];

    [powerView addSubview:lblPowerPhotovoltaic];

    UILabel *lblTPowerPhotovoltaic = [[UILabel alloc] initWithFrame:CGRectMake(25*ProportionX, 11*ProportionX+190*ProportionX+80*ProportionX+25*ProportionX,68*ProportionX, 30*ProportionX)];
    lblTPowerPhotovoltaic.textColor = [UIColor whiteColor];
    lblTPowerPhotovoltaic.font = FontM;
    lblTPowerPhotovoltaic.textAlignment = NSTextAlignmentCenter;
    lblTPowerPhotovoltaic.textColor = [UIColor colorWithRed:90/255.0
                                                      green:190/255.0
                                                       blue:242/255.0
                                                      alpha:1];
    lblTPowerPhotovoltaic.text = @"光伏功率";
    [powerView addSubview:lblTPowerPhotovoltaic];

    UILabel *lblPowerLoad = [[UILabel alloc] initWithFrame:CGRectMake(gap+width * 1, 11*ProportionX+190*ProportionX+80*ProportionX, width, 30*ProportionX)];

    lblPowerLoad.attributedText = [stringColor String:@"1000W"
                                          StringColor:[UIColor colorWithRed:0 green:215/255.0 blue:253/255.0 alpha:1]
                                           StringFont:FontL
                                                  str:@"W"
                                                color:[UIColor whiteColor]
                                                 font:FontS
                                          aligentment:NSTextAlignmentCenter];

    [powerView addSubview:lblPowerLoad];

    UILabel *lblTPowerLoad = [[UILabel alloc] initWithFrame:CGRectMake(gap+width * 1, 11*ProportionX+190*ProportionX+80*ProportionX+25*ProportionX, width, 30*ProportionX)];
    lblTPowerLoad.textColor = [UIColor whiteColor];
    lblTPowerLoad.font = FontM;
    lblTPowerLoad.textAlignment = NSTextAlignmentCenter;
    lblTPowerLoad.textColor = [UIColor colorWithRed:90/255.0
                                              green:190/255.0
                                               blue:242/255.0
                                              alpha:1];
    lblTPowerLoad.text = @"负载功率";
    [powerView addSubview:lblTPowerLoad];

    UILabel *lblPowerGrid = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 38*ProportionX - 50*ProportionX, 11*ProportionX+190*ProportionX+80*ProportionX, 58*ProportionX, 30*ProportionX)];

    lblPowerGrid.attributedText = [stringColor String:[NSString stringWithFormat:@"%@ W",model.gridPower]
                                          StringColor:[UIColor colorWithRed:255/255.0 green:202/255.0 blue:0/255.0 alpha:1]
                                           StringFont:FontL
                                                  str:@"W"
                                                color:[UIColor whiteColor]
                                                 font:FontS
                                          aligentment:NSTextAlignmentCenter];

    [powerView addSubview:lblPowerGrid];

    UILabel *lblTPowerGrid = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 43*ProportionX - 50*ProportionX, 11*ProportionX+190*ProportionX+80*ProportionX +25*ProportionX, 68*ProportionX, 30*ProportionX)];
    lblTPowerGrid.textColor = [UIColor whiteColor];
    lblTPowerGrid.font = FontM;
    lblTPowerGrid.textAlignment = NSTextAlignmentCenter;
    lblTPowerGrid.textColor = [UIColor colorWithRed:90/255.0
                                              green:190/255.0
                                               blue:242/255.0
                                              alpha:1];
    lblTPowerGrid.text = @"电网功率";
    [powerView addSubview:lblTPowerGrid];


}



/**
 当前设备
 */
- (void)loadDeviceView{
    deviceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 294/2.0)];

    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44*ProportionX)];
    lblTitle.font = FontTitle;
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.text = @"当前设备";
    [deviceView addSubview:lblTitle];

    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 44*ProportionX, self.frame.size.width - 20*ProportionX, 1)];
    lblLine.backgroundColor = [UIColor colorWithRed:28/255.0
                                              green:57/255.0
                                               blue:66/255.0
                                              alpha:1];
    [deviceView addSubview:lblLine];

    float gap = 10;
    float width = (self.frame.size.width - 20)/4.0;

    UIButton *btn0 = [[UIButton alloc] initWithFrame:CGRectMake(10 + (width - 40*ProportionX)/2.0 +width*0, 15*ProportionX + 44*ProportionX, 40*ProportionX, 40*ProportionX)];
    [btn0 setBackgroundImage:[UIImage imageNamed:@"当前设备_逆变器"] forState:UIControlStateNormal];
    [deviceView addSubview:btn0];

    UILabel *lblNum0 = [[UILabel alloc] initWithFrame:CGRectMake(10 + width*0, 15*ProportionX + 44*ProportionX + 40*ProportionX + 10*ProportionX, width, 30*ProportionX)];
    lblNum0.textAlignment = NSTextAlignmentCenter;
    lblNum0.font = FontL;
    lblNum0.text = [NSString stringWithFormat:@"%@",model.inverter];
    lblNum0.textColor = [UIColor whiteColor];
    [deviceView addSubview:lblNum0];

    UILabel *lblName0 = [[UILabel alloc] initWithFrame:CGRectMake(10 + width*0, 15*ProportionX + 44*ProportionX + 40*ProportionX + 10*ProportionX+30*ProportionX, width, 30*ProportionX)];
    lblName0.textAlignment = NSTextAlignmentCenter;
    lblName0.textAlignment = NSTextAlignmentCenter;
    lblName0.textColor = [UIColor colorWithRed:85/255.0
                                         green:187/255.0
                                          blue:232/255.0
                                         alpha:1];
    lblName0.font = FontL;
    lblName0.text = @"逆变器";
    [deviceView addSubview:lblName0];

    UILabel *line0 = [[UILabel alloc] initWithFrame:CGRectMake(gap + width, 44*ProportionX, 1, 136*ProportionX)];
    line0.backgroundColor = [UIColor colorWithRed:28/255.0 green:57/255.0 blue:66/255.0 alpha:1];
    [deviceView addSubview:line0];

    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10 + (width - 40*ProportionX)/2.0 +width*1, 15*ProportionX + 44*ProportionX, 40*ProportionX, 40*ProportionX)];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"当前设备_电表"] forState:UIControlStateNormal];
    [deviceView addSubview:btn1];

    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(gap + width*2, 44*ProportionX, 1, 136*ProportionX)];
    line1.backgroundColor = [UIColor colorWithRed:28/255.0 green:57/255.0 blue:66/255.0 alpha:1];
    [deviceView addSubview:line1];

    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(10 + (width - 40*ProportionX)/2.0 +width*2, 15*ProportionX + 44*ProportionX, 40*ProportionX, 40*ProportionX)];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"当前设备_空调"] forState:UIControlStateNormal];
    [deviceView addSubview:btn2];

    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(gap + width*3, 44*ProportionX, 1, 136*ProportionX)];
    line2.backgroundColor = [UIColor colorWithRed:28/255.0 green:57/255.0 blue:66/255.0 alpha:1];
    [deviceView addSubview:line2];

    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(10 + (width - 40*ProportionX)/2.0 +width*3, 15*ProportionX + 44*ProportionX, 40*ProportionX, 40*ProportionX)];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"当前设备_插座"] forState:UIControlStateNormal];
    [deviceView addSubview:btn3];

    UILabel *lblNum1 = [[UILabel alloc] initWithFrame:CGRectMake(10 + width*1, 15*ProportionX + 44*ProportionX + 40*ProportionX + 10*ProportionX, width, 30*ProportionX)];
    lblNum1.textAlignment = NSTextAlignmentCenter;
    lblNum1.font = FontL;
    lblNum1.text = [NSString stringWithFormat:@"%@",model.ameter];
    lblNum1.textColor = [UIColor whiteColor];
    [deviceView addSubview:lblNum1];

    UILabel *lblName1 = [[UILabel alloc] initWithFrame:CGRectMake(10 + width*1, 15*ProportionX + 44*ProportionX + 40*ProportionX + 10*ProportionX+30*ProportionX, width, 30*ProportionX)];
    lblName1.textAlignment = NSTextAlignmentCenter;
    lblName1.textAlignment = NSTextAlignmentCenter;
    lblName1.textColor = [UIColor colorWithRed:85/255.0 green:187/255.0 blue:232/255.0 alpha:1];
    lblName1.font = FontL;
    lblName1.text = @"电表";
    [deviceView addSubview:lblName1];

    UILabel *lblNum2 = [[UILabel alloc] initWithFrame:CGRectMake(10 + width*2, 15*ProportionX + 44*ProportionX + 40*ProportionX + 10*ProportionX, width, 30*ProportionX)];
    lblNum2.textAlignment = NSTextAlignmentCenter;
    lblNum2.font = FontL;
    lblNum2.text = [NSString stringWithFormat:@"%@",model.aircondition];
    lblNum2.textColor = [UIColor whiteColor];
    [deviceView addSubview:lblNum2];

    UILabel *lblName2 = [[UILabel alloc] initWithFrame:CGRectMake(10 + width*2, 15*ProportionX + 44*ProportionX + 40*ProportionX + 10*ProportionX+30*ProportionX, width, 30*ProportionX)];
    lblName2.textAlignment = NSTextAlignmentCenter;
    lblName2.textAlignment = NSTextAlignmentCenter;
    lblName2.textColor = [UIColor colorWithRed:85/255.0 green:187/255.0 blue:232/255.0 alpha:1];
    lblName2.font = FontL;
    lblName2.text = @"空调";
    [deviceView addSubview:lblName2];

    UILabel *lblNum3 = [[UILabel alloc] initWithFrame:CGRectMake(10 + width*3, 15*ProportionX + 44*ProportionX + 40*ProportionX + 10*ProportionX, width, 30*ProportionX)];
    lblNum3.textAlignment = NSTextAlignmentCenter;
    lblNum3.font = FontL;
    lblNum3.text = [NSString stringWithFormat:@"%@",model.socket];
    lblNum3.textColor = [UIColor whiteColor];
    [deviceView addSubview:lblNum3];

    UILabel *lblName3 = [[UILabel alloc] initWithFrame:CGRectMake(10 + width*3, 15*ProportionX + 44*ProportionX + 40*ProportionX + 10*ProportionX+30*ProportionX, width, 30*ProportionX)];
    lblName3.textAlignment = NSTextAlignmentCenter;
    lblName3.textAlignment = NSTextAlignmentCenter;
    lblName3.textColor = [UIColor colorWithRed:85/255.0 green:187/255.0 blue:232/255.0 alpha:1];
    lblName3.font = FontL;
    lblName3.text = @"插座";
    [deviceView addSubview:lblName3];

}


/**
 告警页面
 */
- (void)loadAlertView{
    alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 120/2.0)];

    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(20*ProportionX, 25*ProportionX, 20*ProportionX, 20*ProportionX)];
    img.image = [UIImage imageNamed:@"告警"];
    [alertView addSubview:img];

    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(45*ProportionX, 20*ProportionX, self.frame.size.width - 60*ProportionX, 30*ProportionX)];
    lbltitle.textAlignment = NSTextAlignmentLeft;
    lbltitle.text = @"告警";
    lbltitle.textColor = [UIColor whiteColor];
    lbltitle.font = FontTitle;
    [alertView addSubview:lbltitle];

    UIImageView *imgR = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 30*ProportionX, 25*ProportionX, 20*ProportionX, 20*ProportionX)];
    imgR.image = [UIImage imageNamed:@"more"];
    [alertView addSubview:imgR];

    UILabel *lblNum = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 30*ProportionX - 80*ProportionX, 20*ProportionX, 80*ProportionX, 30*ProportionX)];
    lblNum.textColor = [UIColor redColor];
    lblNum.textAlignment = NSTextAlignmentRight;
    lblNum.text = @"4";
    [alertView addSubview:lblNum];

}

/**
 能源趋势
 */
- (void)loadEnergyView{
    energyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 480/2.0)];

    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44*ProportionX)];
    lblTitle.font = FontTitle;
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.text = @"能源趋势";
    [energyView addSubview:lblTitle];

    btnDay = [[UIButton alloc] initWithFrame:CGRectMake(10 +6*ProportionX, 44*ProportionX, 100*ProportionX, 22*ProportionX)];
    btnDay.layer.borderWidth = 1;
    btnDay.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnDay.layer.masksToBounds = YES;
    btnDay.layer.cornerRadius = 11*ProportionX;
    [btnDay setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay setTitle:@"日" forState:UIControlStateNormal];
    btnDay.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnDay.titleEdgeInsets = UIEdgeInsetsMake(0, 20*ProportionX, 0, 0);
    [btnDay addTarget:self action:@selector(btnDayClickAction) forControlEvents:UIControlEventTouchUpInside];
    [energyView addSubview:btnDay];

    btnYear = [[UIButton alloc] initWithFrame:CGRectMake(10 +6*ProportionX + 50*ProportionX, 44*ProportionX, 100*ProportionX, 22*ProportionX)];
    btnYear.layer.borderWidth = 1;
    btnYear.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnYear.layer.masksToBounds = YES;
    btnYear.layer.cornerRadius = 11*ProportionX;
    [btnYear setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear setTitle:@"年" forState:UIControlStateNormal];
    btnYear.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btnYear.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20*ProportionX);
    [btnYear addTarget:self action:@selector(btnYearClickAction) forControlEvents:UIControlEventTouchUpInside];
    [energyView addSubview:btnYear];

    btnMonth = [[UIButton alloc] initWithFrame:CGRectMake(10 +6*ProportionX +50*ProportionX, 44*ProportionX, 50*ProportionX, 22*ProportionX)];
    btnMonth.layer.borderWidth = 1;
    [btnMonth setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    btnMonth.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnMonth.layer.masksToBounds = YES;
    [btnMonth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnMonth setTitle:@"月" forState:UIControlStateNormal];
    [btnMonth addTarget:self action:@selector(btnMonthClickAction) forControlEvents:UIControlEventTouchUpInside];
    [energyView addSubview:btnMonth];

    btnChoose = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 10 - 6*ProportionX - 90*ProportionX, 44*ProportionX, 90*ProportionX, 22*ProportionX)];
    btnChoose.layer.masksToBounds = YES;
    btnChoose.layer.cornerRadius = 11*ProportionX;
    btnChoose.layer.borderWidth = 1;
    btnChoose.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    [btnChoose setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnChoose setTitle:@"2018" forState:UIControlStateNormal];
    [btnChoose addTarget:self action:@selector(btnChooseClickAction) forControlEvents:UIControlEventTouchUpInside];
    [energyView addSubview:btnChoose];

    //NSArray *tempDataArrOfY2 = @[self->model.photovoltaic_y,self->model.charger_y,self->model.grid_y,self->model.cost_y];
    NSMutableArray *dataAray = [NSMutableArray new];
    if (self->model.photovoltaic_y != nil && [self->model.photovoltaic_y count] > 0) {
        [dataAray addObject:self->model.photovoltaic_y];
    }
    if (self->model.charger_y != nil && [self->model.charger_y count] > 0) {
        [dataAray addObject:self->model.charger_y];
    }
    if (self->model.grid_y != nil && [self->model.grid_y count] > 0) {
        [dataAray addObject:self->model.grid_y];
    }
    if (self->model.cost_y != nil && [self->model.cost_y count] > 0) {
        [dataAray addObject:self->model.cost_y];
    }

    
    aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0,
                                                                            btnDay.frame.origin.y + btnDay.frame.size.height + 30,
                                                                            self.frame.size.width,
                                                                            180*ProportionX)];
    
    [energyView addSubview:aaChartView];
    
    chartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeLine)//设置图表的类型(这里以设置的为柱状图为例)
    //.titleSet(@"编程语言热度")//设置图表标题
    .subtitleFontSizeSet(@0)
    .titleFontSizeSet(@0)
    .markerRadiusSet(@0)
    .xAxisCrosshairColorSet(@"#1d3942")
    .yAxisCrosshairColorSet(@"#1d3942")
    .xAxisLabelsFontSizeSet(@12)
    .yAxisLabelsFontSizeSet(@12)
    .xAxisLabelsFontColorSet(@"#60cdff")
    .yAxisLabelsFontColorSet(@"#60cdff")
    //.legendEnabledSet(NO)
    
    //.yAxisVisibleSet(NO)
    //.subtitleSet(@"虚拟数据")//设置图表副标题
    //.categoriesSet(@[@"Java",@"Swift",@"Python",@"Ruby", @"PHP",@"Go",@"C",@"C#",@"C++"])//设置图表横轴的内容
    .categoriesSet(model.photovoltaic_x)
    .yAxisTitleSet(@"kWh")//设置图表 y 轴的单位
    
    .zoomTypeSet(AAChartZoomTypeX)
    .seriesSet(@[AAObject(AASeriesElement)
                 .colorSet(@"#00fe7d")
                .nameSet(@"光伏产出")
                 
                .dataSet(model.photovoltaic_y),
                AAObject(AASeriesElement)
                 .colorSet(@"#fbd214")
                .nameSet(@"用户消耗")
                .dataSet(model.cost_y),
                AAObject(AASeriesElement)
                 .colorSet(@"#ff653c")
                .nameSet(@"电网取电")
                .dataSet(model.grid_y),
                AAObject(AASeriesElement)
                 .colorSet(@"#ab8dff")
                .nameSet(@"电池发电")
                .dataSet(model.charger_y),
                ]);
    
    [aaChartView aa_drawChartWithChartModel:chartModel];
    
    [aaChartView setIsClearBackgroundColor:YES];
    
    
    
    
//    LRSChartView *sChart = [[LRSChartView alloc]initWithFrame:CGRectMake(0, btnDay.frame.origin.y + btnDay.frame.size.height + 30, self.frame.size.width, 180*ProportionX)];
//
//    //是否可以浮动
//    sChart.isFloating = YES;
//    //设置X轴坐标字体大小
//    sChart.x_Font = [UIFont systemFontOfSize:10];
//    //设置X轴坐标字体颜色
//    sChart.x_Color = [UIColor colorWithHexString:@"0x3D86A6"];
//    //设置Y轴坐标字体大小
//    sChart.y_Font = [UIFont systemFontOfSize:10];
//    //设置Y轴坐标字体颜色
//    sChart.y_Color = [UIColor colorWithHexString:@"0x3D86A6"];
//    //设置X轴数据间隔
//    sChart.Xmargin = 20;
//    //设置背景颜色
//    sChart.backgroundColor = [UIColor clearColor];
//    //是否根据折线数据浮动泡泡
//    //_incomeChartLineView.isFloating = YES;
//    //折线图数据
//    sChart.leftDataArr = dataAray;
//    //折线图所有颜色
//    sChart.leftColorStrArr = @[@"#01FA73",@"#8763FF",@"#268BF6",@"#FF8AC6"];
//    //设置折线样式
//    sChart.chartViewStyle = LRSChartViewMoreClickLine;
//    //设置图层效果
//    sChart.chartLayerStyle = LRSChartNone;
//    //设置折现效果
//    sChart.lineLayerStyle = LRSLineLayerNone;
//    //渐变效果的颜色组
//    sChart.colors = @[@[[UIColor colorWithHexString:@"#febf83"],[UIColor greenColor]],@[[UIColor colorWithHexString:@"#53d2f8"],[UIColor blueColor]],@[[UIColor colorWithHexString:@"#7211df"],[UIColor redColor]]];
//    //渐变开始比例
//    sChart.proportion = 0.5;
//    //底部日期
//    sChart.dataArrOfX = @[@"6:00",@"6:10",@"6:20",@"6:30",@"6:40",@"6:50",@"7:00",@"7:10",@"7:20",@"7:30",@"6:50",@"7:00",@"7:10",@"7:20",@"7:30"];
//    //开始画图
//    [sChart show];
//    [energyView addSubview:sChart];

//    float width = (self.frame.size.width-40*ProportionX)/4.0;
//
//    UILabel *lblLine0 = [[UILabel alloc] initWithFrame:CGRectMake(20*ProportionX, sChart.frame.origin.y + sChart.frame.size.height - 10*ProportionX, sChart.frame.size.width/4.0, 20*ProportionX)];
//
//    lblLine0.attributedText = [stringColor String: [NSString stringWithFormat:@"━ %@",@"光伏产出"]
//                                      StringColor:RGB_HEX(0x55b8e5, 1)
//                                       StringFont:[UIFont systemFontOfSize:14]
//                                              str:@"━"
//                                            color:RGB_HEX(0x00fe7d, 1)
//                                             font:[UIFont systemFontOfSize:14]
//                                      aligentment:NSTextAlignmentCenter];
//
//    [energyView addSubview:lblLine0];
//
//    UILabel *lblLine1 = [[UILabel alloc] initWithFrame:CGRectMake(20*ProportionX + width, sChart.frame.origin.y + sChart.frame.size.height - 10*ProportionX, sChart.frame.size.width/4.0, 20*ProportionX)];
//
//    lblLine1.attributedText = [stringColor String: [NSString stringWithFormat:@"━ %@",@"用户消耗"]
//                                      StringColor:RGB_HEX(0x55b8e5, 1)
//                                       StringFont:[UIFont systemFontOfSize:14]
//                                              str:@"━"
//                                            color:RGB_HEX(0xfbd214, 1)
//                                             font:[UIFont systemFontOfSize:14]
//                                      aligentment:NSTextAlignmentCenter];
//
//    [energyView addSubview:lblLine1];
//
//    UILabel *lblLine2 = [[UILabel alloc] initWithFrame:CGRectMake(20*ProportionX + width * 2, sChart.frame.origin.y + sChart.frame.size.height - 10*ProportionX, sChart.frame.size.width/4.0, 20*ProportionX)];
//
//    lblLine2.attributedText = [stringColor String: [NSString stringWithFormat:@"━ %@",@"电网取电"]
//                                      StringColor:RGB_HEX(0x55b8e5, 1)
//                                       StringFont:[UIFont systemFontOfSize:14]
//                                              str:@"━"
//                                            color:RGB_HEX(0xff653c, 1)
//                                             font:[UIFont systemFontOfSize:14]
//                                      aligentment:NSTextAlignmentCenter];
//
//    [energyView addSubview:lblLine2];
//
//    UILabel *lblLine3 = [[UILabel alloc] initWithFrame:CGRectMake(20*ProportionX + width * 3, sChart.frame.origin.y + sChart.frame.size.height - 10*ProportionX, sChart.frame.size.width/4.0, 20*ProportionX)];
//
//    lblLine3.attributedText = [stringColor String: [NSString stringWithFormat:@"━ %@",@"来自电池"]
//                                      StringColor:RGB_HEX(0x55b8e5, 1)
//                                       StringFont:[UIFont systemFontOfSize:14]
//                                              str:@"━"
//                                            color:RGB_HEX(0xab8dff, 1)
//                                             font:[UIFont systemFontOfSize:14]
//                                      aligentment:NSTextAlignmentCenter];
//
//    [energyView addSubview:lblLine3];


}

/**
 环境贡献
 */
- (void)loadContributeView{
    contributeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, (CGFloat) (260/2.0))];

    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, (CGFloat) (44*ProportionX))];
    lblTitle.font = FontTitle;
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.text = @"环境贡献";
    [contributeView addSubview:lblTitle];

    float width = (float) ((self.frame.size.width - 20) / 3.0);
    float x = (float) ((width - 40*ProportionX)/2.0);

    UIButton *btnCo2 = [[UIButton alloc] initWithFrame:CGRectMake(10 + x + width * 0, (CGFloat) (44*ProportionX), (CGFloat) (40*ProportionX), (CGFloat) (40*ProportionX))];
    [btnCo2 setBackgroundImage:[UIImage imageNamed:@"环保_co2"] forState:UIControlStateNormal];
    [contributeView addSubview:btnCo2];

    UILabel *lblCo20;
    lblCo20 = [[UILabel alloc] initWithFrame:CGRectMake(10 + width*0, (CGFloat) (44*ProportionX +44*ProportionX), width, (CGFloat) (30*ProportionX))];

    lblCo20.attributedText = [stringColor String: [NSString stringWithFormat:@"%@ kg",model.CO2]
                                     StringColor:RGB_HEX(0xffffff, 1)
                                      StringFont:FontL
                                             str:@"kg"
                                           color:RGB_HEX(0x55b8e5, 1)
                                            font:FontS
                                     aligentment:NSTextAlignmentCenter];

    [contributeView addSubview:lblCo20];


    UILabel *lblCo21;
    lblCo21 = [[UILabel alloc] initWithFrame:CGRectMake(10 + width*0, (CGFloat) (44*ProportionX +44*ProportionX +30*ProportionX), width, (CGFloat) (30*ProportionX))]   ;
    lblCo21.text = @"二氧化碳减排";
    lblCo21.textAlignment = NSTextAlignmentCenter;
    lblCo21.textColor = [UIColor colorWithRed:(CGFloat) (85 / 255.0) green:(CGFloat) (184 / 255.0) blue:(CGFloat) (229 / 255.0) alpha:1];
    [contributeView addSubview:lblCo21];

    UIButton *btnCoal = [[UIButton alloc] initWithFrame:CGRectMake(10 + x + width * 1, (CGFloat) (44*ProportionX), (CGFloat) (40*ProportionX), (CGFloat) (40*ProportionX))];
    [btnCoal setBackgroundImage:[UIImage imageNamed:@"环保_coal"] forState:UIControlStateNormal];
    [contributeView addSubview:btnCoal];

    UILabel *lblCoal0 = [[UILabel alloc] initWithFrame:CGRectMake(10 + width*1, (CGFloat) (44*ProportionX +44*ProportionX), width, (CGFloat) (30*ProportionX))];

    lblCoal0.attributedText = [stringColor String: [NSString stringWithFormat:@"%@ kg",model.Coal]
                                      StringColor:RGB_HEX(0xffffff, 1)
                                       StringFont:FontL
                                              str:@"kg"
                                            color:RGB_HEX(0x55b8e5, 1)
                                             font:FontS
                                      aligentment:NSTextAlignmentCenter];

    [contributeView addSubview:lblCoal0];

    UILabel *lblCoal1 = [[UILabel alloc] initWithFrame:CGRectMake(10 + width*1, (CGFloat) (44*ProportionX +44*ProportionX +30*ProportionX), width, (CGFloat) (30*ProportionX))];
    lblCoal1.text = @"节约煤";
    lblCoal1.textAlignment = NSTextAlignmentCenter;
    lblCoal1.textColor = [UIColor colorWithRed:(CGFloat) (85 / 255.0) green:(CGFloat) (184 / 255.0) blue:(CGFloat) (229 / 255.0) alpha:1];
    [contributeView addSubview:lblCoal1];

    UIButton *btnTree = [[UIButton alloc] initWithFrame:CGRectMake(10 + x + width * 2, (CGFloat) (44*ProportionX), (CGFloat) (40*ProportionX), (CGFloat) (40*ProportionX))];
    [btnTree setBackgroundImage:[UIImage imageNamed:@"环保_tree"] forState:UIControlStateNormal];
    [contributeView addSubview:btnTree];

    UILabel *lblTree0;
    lblTree0 = [[UILabel alloc] initWithFrame:CGRectMake(10 + width*2, (CGFloat) (44*ProportionX +44*ProportionX), width, (CGFloat) (30*ProportionX))];

    lblTree0.attributedText = [stringColor String: [NSString stringWithFormat:@"%@ 颗",model.Tree]
                                      StringColor:RGB_HEX(0xffffff, 1)
                                       StringFont:FontL
                                              str:@"颗"
                                            color:RGB_HEX(0x55b8e5, 1)
                                             font:FontS
                                      aligentment:NSTextAlignmentCenter];

    [contributeView addSubview:lblTree0];

    UILabel *lblTree1;
    lblTree1 = [[UILabel alloc] initWithFrame:CGRectMake(10 + width*2, (CGFloat) (lblTree0.frame.origin.y + 30*ProportionX), width, (CGFloat) (30*ProportionX))];
    lblTree1.text = @"植树";
    lblTree1.textAlignment = NSTextAlignmentCenter;
    lblTree1.textColor = [UIColor colorWithRed:(CGFloat) (85 / 255.0) green:(CGFloat) (184 / 255.0) blue:(CGFloat) (229 / 255.0) alpha:1];
    [contributeView addSubview:lblTree1];
}


/**
 天气视图
 */
- (void)loadWeatherView
{
    weatherView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, (CGFloat) (150 / 2.0))];

    UIImageView *imgWeather = [[UIImageView alloc] initWithFrame:CGRectMake((CGFloat) (10 + 11 * ProportionX), (CGFloat) (15 * ProportionX), (CGFloat) (20 * ProportionX), (CGFloat) (20 * ProportionX))];
    imgWeather.image = [UIImage imageNamed:@"weather_sun"];
    [weatherView addSubview:imgWeather];

    UILabel *lblWeather = [[UILabel alloc] initWithFrame:CGRectMake((CGFloat) (10 + 11 * ProportionX + 20 * ProportionX + 5 * ProportionX), (CGFloat) (15 * ProportionX), (CGFloat) (200 * ProportionX), (CGFloat) (20 * ProportionX))];
    lblWeather.text = [NSString stringWithFormat:@"%@°C %@",model.temp1,model.weather];
    lblWeather.textColor = [UIColor whiteColor];
    [weatherView addSubview:lblWeather];

    UIImageView *imgLocation = [[UIImageView alloc] initWithFrame:CGRectMake((CGFloat) (10 + 11 * ProportionX), (CGFloat) (15 * ProportionX + 20 * ProportionX + 15 * ProportionX), (CGFloat) (20 * ProportionX), (CGFloat) (20 * ProportionX))];
    imgLocation.image = [UIImage imageNamed:@"weather_location"];
    [weatherView addSubview:imgLocation];

    UILabel *lblLocation = [[UILabel alloc] initWithFrame:CGRectMake((CGFloat) (10 + 11 * ProportionX + 20 * ProportionX + 5 * ProportionX), (CGFloat) (15 * ProportionX + 20 * ProportionX + 15 * ProportionX), (CGFloat) (200 * ProportionX), (CGFloat) (20 * ProportionX))];
    lblLocation.text = [NSString stringWithFormat:@"%@",model.city];
    lblLocation.textColor = [UIColor colorWithRed:(CGFloat) (77 / 255.0) green:(CGFloat) (170 / 255.0) blue:(CGFloat) (212 / 255.0) alpha:1];
    [weatherView addSubview:lblLocation];

    UIImageView *imgWind = [[UIImageView alloc] initWithFrame:CGRectMake((CGFloat) (10 + 11 * ProportionX + self.frame.size.width / 2.0), (CGFloat) (15 * ProportionX + 20 * ProportionX + 15 * ProportionX), (CGFloat) (20 * ProportionX), (CGFloat) (20 * ProportionX))];
    imgWind.image = [UIImage imageNamed:@"weather_wind"];
    [weatherView addSubview:imgWind];

    UILabel *lblWind = [[UILabel alloc] initWithFrame:CGRectMake((CGFloat) (10 + 11 * ProportionX + 20 * ProportionX + 5 * ProportionX + self.frame.size.width / 2.0), (CGFloat) (15 * ProportionX + 20 * ProportionX + 15 * ProportionX), (CGFloat) (200 * ProportionX), (CGFloat) (20 * ProportionX))];
    lblWind.text = [NSString stringWithFormat:@"%@ %@ 级",model.windD,model.wind];
    lblWind.textColor = [UIColor colorWithRed:(CGFloat) (77 / 255.0) green:(CGFloat) (170 / 255.0) blue:(CGFloat) (212 / 255.0) alpha:1];
    [weatherView addSubview:lblWind];



}


#pragma mark - 动作

//animate
- (void)changeImageHome
{
    if (t == 0)
    {
        t = t+1;
        imgAL.image = [UIImage imageNamed:@"光伏功率_流动_work1"];
        imgRL.image = [UIImage imageNamed:@"电网功率_流动_work1"];
    }
    else if (t == 1)
    {
        t = t+1;
        imgAL.image = [UIImage imageNamed:@"光伏功率_流动_work2"];
        imgRL.image = [UIImage imageNamed:@"电网功率_流动_work2"];
    }
    else
    {
        t=0;
        imgAL.image = [UIImage imageNamed:@"光伏功率_流动_work3"];
        imgRL.image = [UIImage imageNamed:@"电网功率_流动_work3"];
    }
}

//animate
- (void)RotaAnimate{
    [imgTotol.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];//开始动画
    [imgLAround.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];//开始动画
    [imgRAround.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];//开始动画
}

////逆变器四个
//- (void)btnInverterClickAction{
//    NSLog(@"Inverter");
//    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)])
//    {
//        [self.customDelegate btnClickWithTag:@"Inverter"];
//    }
//}
//
//- (void)btnElectricMeterClickAction{
//    NSLog(@"ElectricMeter");
//    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)])
//    {
//        [self.customDelegate btnClickWithTag:@"ElectricMeter"];
//    }
//}
//
//- (void)btnAirConditioningClickAction{
//    NSLog(@"AirConditioning");
//    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
//        [self.customDelegate btnClickWithTag:@"AirConditioning"];
//    }
//}
//
//- (void)btnSocketClickAction{
//    NSLog(@"Socket");
//    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
//        [self.customDelegate btnClickWithTag:@"Socket"];
//    }
//}

//日月年按钮
- (void)btnDayClickAction{
    [btnDay setBackgroundColor:[UIColor colorWithRed:(CGFloat) (4 / 255.0) green:(CGFloat) (120 / 255.0) blue:(CGFloat) (204 / 255.0) alpha:1]];
    [btnDay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [btnMonth setBackgroundColor:[UIColor colorWithRed:(CGFloat) (2 / 255.0) green:(CGFloat) (33 / 255.0) blue:(CGFloat) (43 / 255.0) alpha:1]];
    [btnMonth setTitleColor:[UIColor colorWithRed:(CGFloat) (4 / 255.0) green:(CGFloat) (120 / 255.0) blue:(CGFloat) (204 / 255.0) alpha:1] forState:UIControlStateNormal];

    [btnYear setBackgroundColor:[UIColor clearColor]];
    [btnYear setTitleColor:[UIColor colorWithRed:(CGFloat) (4 / 255.0) green:(CGFloat) (120 / 255.0) blue:(CGFloat) (204 / 255.0) alpha:1] forState:UIControlStateNormal];
    
    timeType = 2;
    [self getEnergyTendencyWithUniqueId:uniqueId andTimeType:timeType andTime:[time substringToIndex:6]];
}

- (void)btnMonthClickAction{
    [btnDay setBackgroundColor:[UIColor clearColor]];
    [btnDay setTitleColor:[UIColor colorWithRed:(CGFloat) (4 / 255.0) green:(CGFloat) (120 / 255.0) blue:(CGFloat) (204 / 255.0) alpha:1] forState:UIControlStateNormal];

    [btnMonth setBackgroundColor:[UIColor colorWithRed:(CGFloat) (4 / 255.0) green:(CGFloat) (120 / 255.0) blue:(CGFloat) (204 / 255.0) alpha:1]];
    [btnMonth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [btnYear setBackgroundColor:[UIColor clearColor]];
    [btnYear setTitleColor:[UIColor colorWithRed:(CGFloat) (4 / 255.0) green:(CGFloat) (120 / 255.0) blue:(CGFloat) (204 / 255.0) alpha:1] forState:UIControlStateNormal];
    
    timeType = 3;
    [self getEnergyTendencyWithUniqueId:uniqueId andTimeType:timeType andTime:[time substringToIndex:4]];
}


- (void)btnYearClickAction{
    [btnDay setBackgroundColor:[UIColor clearColor]];
    [btnDay setTitleColor:[UIColor colorWithRed:(CGFloat) (4 / 255.0) green:(CGFloat) (120 / 255.0) blue:(CGFloat) (204 / 255.0) alpha:1] forState:UIControlStateNormal];

    [btnMonth setBackgroundColor:[UIColor colorWithRed:(CGFloat) (2 / 255.0) green:(CGFloat) (33 / 255.0) blue:(CGFloat) (43 / 255.0) alpha:1]];
    [btnMonth setTitleColor:[UIColor colorWithRed:(CGFloat) (4 / 255.0) green:(CGFloat) (120 / 255.0) blue:(CGFloat) (204 / 255.0) alpha:1] forState:UIControlStateNormal];

    [btnYear setBackgroundColor:[UIColor colorWithRed:(CGFloat) (4 / 255.0) green:(CGFloat) (120 / 255.0) blue:(CGFloat) (204 / 255.0) alpha:1]];
    [btnYear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    timeType = 4;
    [self getEnergyTendencyWithUniqueId:uniqueId andTimeType:timeType andTime:[time substringToIndex:4]];
}


- (void)btnChooseClickAction{
    __weak typeof(self) weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:UIDatePickerModeDate defaultSelValue:weakSelf.birthdayTF.text minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:NO resultBlock:^(NSString *selectValue) {

        [self->btnChoose setTitle:[NSString stringWithFormat:@"%@",selectValue] forState:UIControlStateNormal];
        
        NSArray *array = [selectValue componentsSeparatedByString:@"-"];
        
        if(self->timeType == 2){
            [self getEnergyTendencyWithUniqueId:self->uniqueId andTimeType:self->timeType andTime:[NSString stringWithFormat:@"%@%@",array[0],array[1]]];
        }else{
            [self getEnergyTendencyWithUniqueId:self->uniqueId andTimeType:self->timeType andTime:array[0]];
        }
        
        CGSize size = [self->btnChoose.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: FontM}];
        self->btnChoose.frame = CGRectMake((CGFloat) (self.frame.size.width - 10 - 6*ProportionX - size.width - 20*ProportionX), (CGFloat) (44*ProportionX), (CGFloat) (size.width + 20*ProportionX), (CGFloat) (22*ProportionX));
    }];
}


@end
