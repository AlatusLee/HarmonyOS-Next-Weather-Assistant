import { cityView } from '../view/cityView';
import getWeatherUtil from "../viewmodel/getWeatherUtil";
import { weatherModel } from '../viewmodel/weatherModel';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  // 城市代码集合
  @State cityCodeList:number[] = [440300,440100];
  // 城市名字集合
  @State cityNameList:string[] = [];
  // 城市信息集合
  @State cityWeatherList:Array<weatherModel> = [];
  // 当前城市索引
  @State cityIndex:number = 0;
  tabController:TabsController = new TabsController();
  // 按钮样式
  @Builder tabBuild(index:number){
    Circle({width:10,height:10}).fill(this.cityIndex === index?Color.White:Color.Gray).opacity(0.4);
  }
  onPageShow(): void {
    let params:object = router.getParams();
    if(params!=null){
      this.cityCodeList = params["codes"];
      this.cityWeatherList = [];
      this.cityNameList = [];
      this.initDate();
    }
  }
  // 获取数据
  aboutToAppear(): void {
    this.initDate();
  }
  // 初始化方法
  async initDate(){
    let result:Array<weatherModel> = await getWeatherUtil.getWeathers(this.cityCodeList);
    for (let i = 0; i < result.length; i++) {
      let weather:weatherModel = result[i];
      this.cityWeatherList.push(weather);
      this.cityNameList.push(weather.forecasts[0].city);
    }
  }
  build() {
    Column(){
      Row(){
        Button("添加")
          .fontSize(25)
          .fontColor(Color.White) // 白色字体
          .opacity(1) // 完全不透明
          .backgroundColor("#006400") // 深蓝色背景
          .margin({ bottom: 10,left: 10 })
          .onClick(()=>{
            router.pushUrl({
              url: "pages/AddCity",
              params: {
                codes: this.cityCodeList,
                names: this.cityNameList
              }
            });
          });
        Text(this.cityNameList[this.cityIndex])
          .fontSize(40)
          .fontColor("#333333"); // 深灰色字体
        Button("删除")
          .fontSize(25)
          .fontColor(Color.White) // 白色字体，确保对比度足够高
          .opacity(1) // 完全不透明
          .backgroundColor("#FF0000") // 红色背景
          .margin({ bottom: 10,right: 10 })
          .onClick(()=>{
            AlertDialog.show({
              title: "删除",
              message: `你确定要删除${this.cityNameList[this.cityIndex]}的天气信息吗`,
              primaryButton: {
                value: '取消',
                action: () => {
                  console.info('取消删除');
                },
              },
              secondaryButton: {
                value: '删除',
                action: () => {
                  console.log(this.cityNameList.length.toString());
                  console.log(this.cityNameList.toString());
                  if(this.cityNameList.length > 1){
                    this.cityNameList = this.cityNameList.filter(item=>item!==this.cityNameList[this.cityIndex]);
                    this.cityCodeList = this.cityCodeList.filter(item=>item!==this.cityCodeList[this.cityIndex]);
                    this.cityWeatherList = this.cityWeatherList.filter(item=>item!==this.cityWeatherList[this.cityIndex]);
                  }
                  else{
                    AlertDialog.show({
                      title: "无法删除",
                      message: "您最少需要保留一个城市信息"
                    });
                  }
                }
              },
            })
          });
      }.width("100%").height("10%").justifyContent(FlexAlign.SpaceBetween);
      Tabs({barPosition:BarPosition.Start,controller:this.tabController}){
        ForEach(this.cityWeatherList,(cityWeather:weatherModel)=>{
          TabContent(){
            cityView({casts:cityWeather.forecasts[0].casts});
          }.tabBar(this.tabBuild(this.cityWeatherList.findIndex(obj=>obj===cityWeather)));
        });
      }.barWidth(40).barHeight(30).onChange((index:number)=>{
        this.cityIndex = index;
      });
    }.width("100%").height("100%").backgroundColor("#87CEEB");
  }
}