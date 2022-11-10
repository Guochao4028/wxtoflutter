// index.js
// 获取应用实例
const app = getApp()

Page({
  data: {
    loginCode: '',
    phoneNumber: '',
  },
  onLoad() {
    if (wx.getUserProfile) {
      this.setData({
        canIUseGetUserProfile: true
      })
    }
  },
///调用系统登录
  getLoginCode() {
    wx.login({
      success: (res) => {
        console.log(res)
        if (res.code) {
          this.setData({
            loginCode : res.code
          })
        }
      }
    })
  },
  ///获取按钮事件
  getPhoneNumber (e) {
    console.log(e)
    console.log(e.detail.code)
    this.getLoginCode()
    if(e.detail.code){
    this.getPhone(e.detail.code)
    }
  },
///获得手机号
  getPhone(code) {
    wx.request({
      url: 'https://api.dev.nowcheck.cn/login/oauth2/wechat/accessToken',
      data:{code:code},
      method:"POST",
      header: {
       'content-type': 'application/x-www-form-urlencoded',
     },
      success:(res)=>{
        phoneNumber = res.data.data.phoneNumber

        this.setData({
          phoneNumber : phoneNumber
        })
        console.log("phone >> "+phoneNumber)
        this.loginMiniProgram(phoneNumber)
      },
    })
  },
///登录小程序
  loginMiniProgram(phoneNumber){
    loginCode = this.data.loginCode
    wx.request({
      url: 'https://api.dev.nowcheck.cn/login/oauth2/wechat/miniProgram',
      data:{code:loginCode, phone:phoneNumber, loginType:1},
      method:"POST",
      header: {
       'content-type': 'application/x-www-form-urlencoded',
     },
      success:(res)=>{
        console.log(res)
         accessToken =  res.data.data.accessToken
         wx.setStorage({
          key:"accessToken",
          data:accessToken
        })
console.log(this.data.phoneNumber)
        wx.navigateTo({
          url:'/pages/web/web?accessToken='+accessToken+'&phoneNumber='+this.data.phoneNumber
        })
         
      },
    })
  },

})