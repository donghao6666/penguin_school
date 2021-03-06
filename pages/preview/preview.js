// pages/preview/preview.js
const app = getApp()
Page({
  /**
   * 页面的初始数据
   */
  data: {
    detail_load: false,
    item: {},
    height: app.globalData.nav_bar_height,
    system: app.globalData.system,
    is_hide: !1,
    animationData: {},
    topAniData: {},
    imgAniData: {},
    comAniData: {},
    actionSheetHidden: true,
    //是否采用衔接滑动
    circular: true,
    //是否显示画板指示点
    indicatorDots: false,
    //选中点的颜色
    indicatorcolor: "#000",
    //是否竖直
    vertical: false,
    //是否自动切换
    autoplay: true,
    //自动切换的间隔
    interval: 2500,
    //滑动动画时长毫秒
    duration: 100,
    //所有图片的高度
    imgheights: [],
    //图片宽度
    imgwidth: 750,
    //默认
    current: 0
  },
  imageLoad: function (e) {//获取图片真实宽度
    var imgwidth = e.detail.width,
        imgheight = e.detail.height,
        //宽高比
        ratio = imgwidth / imgheight;
    //计算的高度值
    var viewHeight = 750 / ratio;
    var imgheight = viewHeight;
    var imgheights = this.data.imgheights;
    //把每一张图片的对应的高度记录到数组里
    imgheights[e.target.dataset.id] = imgheight;
    this.setData({
      imgheights: imgheights
    })
  },
  bindchange: function (e) {
    // console.log(e.detail.current)
    this.setData({ current: e.detail.current })
  },
  back_page: function(){
    if(this.data.detail_load){
      qq.switchTab({
        url:'/pages/home/home'
      })
    } else {
      wx.navigateBack({
        delta: 1
      })
    }
  },
  onShareAppMessage(res){
    let gallary = this.data.gallary;
    return {
      title: gallary.title,
      imageUrl:gallary.imgs[0], // 图片 URL
      path:"pages/preview/preview?gallary_id="+gallary.id, // 图片 URL
      query:'gallary_id='+gallary.id,
      success: function () {
        app.ShowToast('恭喜，转发成功！')
      },
      fail() {
        app.ShowToast('网络错误，转发失败！')
      }
    }
  },
  onLoad: function(options){
    let Id = options.imgid;
    if(!Id){
      var obj = qq.getLaunchOptionsSync();
      Id = obj.query.gallary_id;
      this.setData({
        detail_load:true
      })
    }
    let that = this;
    app.WxHttpRequestGet('gallary_detail',{gallaryId:Id},function (res) {
        let data = res.data;
        if(data.code === 200){
          that.setData({
            gallary:data.data
          })
        }else{
          app.ShowQQmodal(data.message, "");
        }
    })
  },
  FavorClick(e){
    let is_auth = app.AUthCheck();
    if (!is_auth){
      return
    }
    let that = this;
    let dataset = e.currentTarget.dataset;
    const gallary_id = dataset.id;
    const count = dataset.count;
    app.WxHttpRequestPOST('gallary_favor',{gallary_id:gallary_id},function (res) {
      const data =res.data;
      if(data.code == 200){
        let key = 'gallary.favor_count';
        let status = 'gallary.status';
        that.setData({
          [key]:data.data === 'normal'?count+1:count-1,
          [status]:data.data === 'normal'?'favor':false
        })
      }else{
        app.ShowQQmodal(data.message, "");
      }
    },app.InterError)
  },
  onReady(){
    const animation = wx.createAnimation({
      duration: 400,
      timingFunction: 'ease',
    })
    const topAni = wx.createAnimation({
      duration: 400,
      timingFunction: 'ease',
    })
    const imgAni = wx.createAnimation({
      duration: 400,
      timingFunction: 'ease',
    })
    const comAni = wx.createAnimation({
      duration: 400,
      timingFunction: 'ease',
    })
    this.topAni = topAni
    this.animation = animation
    this.imgAni = imgAni
    this.comAni = comAni
  },
  show_all: function(){
    let self = this, d = self.data;
    if (!d.info_show){
      this.animation.backgroundColor('#000')
      this.animation.opacity(1)
      this.animation.translateY(-150).step()
      this.imgAni.translateY(-200)
      this.imgAni.scale(1.5, 1.5).step()
      this.topAni.rotate(180).step()

      this.setData({
        animationData: this.animation.export(),
        topAniData: this.topAni.export(),
        imgAniData: this.imgAni.export(),
        info_show: !d.info_show
      })
    }else{
      this.animation.translateY(0).step()
      this.imgAni.translateY(0)
      this.imgAni.scale(1, 1).step()
      this.animation.opacity(0.8).step()
      this.topAni.rotate(0).step()

      this.setData({
        animationData: this.animation.export(),
        topAniData: this.topAni.export(),
        imgAniData: this.imgAni.export(),
        info_show: !d.info_show
      })
    }
  },
  download_img () {
    let gallary = this.data.gallary;
    let imgs = gallary.imgs;
    for(let i=0;i<imgs.length;i++){
      app.qqshowloading('图片下载中...');
      qq.downloadFile({
        url:imgs[i],
        success: function(res) {
          qq.saveImageToPhotosAlbum({
            filePath: res.tempFilePath,
            success: function(data) {
              qq.showToast({
                title: "相册图片保存成功！",
                icon: "success",
                duration: 2000
              });
              qq.hideLoading()
            },
            fail: function(err) {
              app.ShowToast('保存错误！');
            }
          });
        }
      });
    }
  },
  save: function (e) {
    var that = this;
    //获取相册授权
    wx.getSetting({
      success(res) {
        if (!res.authSetting['scope.writePhotosAlbum']) {
          wx.authorize({
            scope: 'scope.writePhotosAlbum',
            success() {//这里是用户同意授权后的回调
              that.download_img()
            },
            fail() {//这里是用户拒绝授权后的回调
              wx.showModal({
                title: '警告',
                content: '您拒绝了授权，无法下载图片，点击确定重新授权',
                success: function (res) {
                  if (res.confirm){
                    wx.openSetting({
                      success(res){
                        if (res.authSetting["scope.writePhotosAlbum"]) {
                          that.download_img()
                        }
                      }
                    })
                  }
                }
              })
            }
          })
        } else {//用户已经授权过了
          that.download_img()
        }
      }
    })
  },
  onShow (e) {
    console.log(e)
  },
  action_sheet(e) {
    this.setData({
      actionSheetHidden: !this.data.actionSheetHidden
    })
  },
})
