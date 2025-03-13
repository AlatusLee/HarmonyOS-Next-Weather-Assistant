import { weatherModel } from './weatherModel'
import http from '@ohos.net.http';
import key from '../const/key';

class getWeatherUtil{
  // 发送一个URL请求,返回对应的数据
  getWeather(cityCode:number){
    return new Promise<weatherModel>((resolve,reject)=>{
      let request = http.createHttp();
      let url = `https://restapi.amap.com/v3/weather/weatherInfo?city=${cityCode}&extensions=all&key=${key}`;
      let result = request.request(url);
      result.then((res)=>{
        if(res.responseCode===200){
          resolve(JSON.parse(res.result.toString()));
        }
      }).catch((err:object)=>{
        console.log(err.toString());
      });
    });
  }
  // 多个URL,一并返回结果
  async getWeathers(cityCodes:Array<number>){
    let promises:Array<Promise<weatherModel>> = [];
    let weatherModels:Array<weatherModel> = [];
    for (let i = 0; i < cityCodes.length; i++) {
      promises.push(this.getWeather(cityCodes[i]));
    }
    await Promise.all(promises).then(result => {
      weatherModels = result;
    });
    return weatherModels;
  }
}

export default new getWeatherUtil() as getWeatherUtil;