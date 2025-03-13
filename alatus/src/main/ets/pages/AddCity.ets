import router from '@ohos.router';

@Entry
@Component
struct AddCity {
  @State allCityCodeList:number[] =
    [440300,440100,310000,110000,320100,420100,510100,500000,610100,410100];
  @State allCityNameList:string[] =
    ["深圳市","广州市","上海市","北京市","南京市","武汉市","成都市","重庆市","西安市","郑州市"];
  @State cityCodeList:number[] = [];
  @State cityNameList:string[] = [];
  onPageShow(): void {
    let params:object = router.getParams();
    this.cityCodeList = params["codes"];
    this.cityNameList = params["names"];
    console.log(this.cityCodeList.toString());
    console.log(this.cityNameList.toString());
  }
  build() {
    Column(){
      Row(){
        Text("添加城市列表").fontSize(35).fontColor(Color.White);
        Blank();
        Button("完成").fontSize(26).onClick(()=>{
          router.back({
            url: "pages/Index",
            params: {
              codes: this.cityCodeList,
              names: this.cityNameList
            }
          });
        });
      }.height("10%").width("95%");
      Column(){
        List(){
          ForEach(this.allCityNameList,(name:string)=>{
            ListItem(){
              if(this.cityNameList.includes(name)){
                Column(){
                  Row(){
                    Text(name).fontSize(35).fontColor(Color.White)
                      .width("60%").margin({top:20,left:30});
                    Blank()
                    Text("已添加").fontSize(18).backgroundColor("")
                      .opacity(0.8).margin({top:5,right: 20});
                  }.width("100%");
                  Blank();
                  Divider().strokeWidth(5);
                }.height(90).width("100%").margin({top:20}).backgroundColor("#4682B4");
              }
              else{
                Column(){
                  Row(){
                    Text(name).fontSize(35).fontColor(Color.White)
                      .width("60%").margin({top:20,left:30});
                    Blank();
                    Button("添加").backgroundColor("").fontSize(18).margin({right:10})
                      .onClick(()=>{
                        // 根据name获取所在索引
                        let index = this.allCityNameList.findIndex(obj=>obj===name);
                        // 根据获得的索引获取cityCode
                        let cityCode:number = this.allCityCodeList[index];
                        this.cityCodeList.push(cityCode);
                        this.cityNameList.push(name);
                      });
                  }.width("100%")
                  Blank();
                  Divider().strokeWidth(5);
                }.height(90).width("100%").margin({top:20});
              }
            }
          });
        }
      }.width("100%").height("90%");
    }.width("100%").height("100%").backgroundColor("#87CEEB");
  }
}