import { cast } from '../viewmodel/cast';

@Component
export struct cityView{
  // 获取数据,城市数据
  casts:Array<cast> = [];
  @Builder weatherImage(weather:string,width:number,height:number){
    if(weather === "晴"){
      Image("https://i-blog.csdnimg.cn/direct/bf01538113ef4f218fd4495c430e0568.jpeg")
        .width(width).height(height);
    }
    if(weather === "阴"){
      Image("https://i-blog.csdnimg.cn/direct/cdccb8075bb8473db2672bed70190ba7.jpeg")
        .width(width).height(height);
    }
    if(weather === "多云"){
      Image("https://i-blog.csdnimg.cn/direct/cc6430c2542b4f49b98d33bac2005829.jpeg")
        .width(width).height(height);
    }
    if(weather.includes("雨")){
      Image("https://i-blog.csdnimg.cn/direct/de1260f193c446e7a1e9468140997ae2.jpeg")
        .width(width).height(height);
    }
  }
  // 展示数据
  build() {
    Column(){
      // 当天天气数据
      ForEach(this.casts,(cast:cast)=>{
        if(this.casts[0] === cast){
          // 图片渲染
          this.weatherImage(cast.dayweather,260,200)
          Column(){
            // 日期,气温,天气
            Text(`${cast.dayweather} ${cast.daytemp}° 至 ${cast.nighttemp}°`).fontSize(30)
              .fontColor(Color.White).fontWeight(FontWeight.Bold);
            Text(`${cast.daywind}风${cast.daypower}级`).fontSize(30)
              .fontColor(Color.White).fontWeight(FontWeight.Bold);
          }.margin({top:15});
          Column(){
            Text("近期天气").fontSize(26).margin({top:10});
            Row(){
              // 遍历天气
              ForEach(this.casts,(cast:cast)=>{
                Column(){
                  Text(cast.date.substring(5));
                  this.weatherImage(cast.dayweather,20,20);
                  Text(cast.dayweather);
                  Text(cast.daytemp.toString());
                  Line().width(20).height(80).startPoint([10,0]).endPoint([10,70])
                    .stroke(Color.Black).strokeWidth(3).strokeDashArray([10,3]);
                  Text(cast.nighttemp.toString());
                  this.weatherImage(cast.nightweather,20,20);
                  Text(cast.nightweather);
                }.width("20%").height("90%");
              });
            }.width("80%").height("60%")
            .backgroundColor("#ffbab8b8")
            .opacity(0.5)
            .justifyContent(FlexAlign.SpaceAround);
          }.width("100%").height("55%");
        }
      });
    }.width("100%").height("100%");
  }
}