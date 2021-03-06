<view class="page-container" bindtap="HandleClick">
  <view class="sub-model">
    <view class="sub-title text-black">推荐活动</view>
    <view class="sub-more text-grey">查看更多<text class="cuIcon-right text-grey"></text></view>
  </view>
  <view class="scroll_box border-main">
    <scroll-view class="scroll-view_x" scroll-x style="width: auto;overflow:hidden;">
      <view class="item_list" qq:for="{{recommend}}">
        <image src="{{item.face}}" class="item_book_img" mode="aspectFill"></image>
        <view class="text-black text-size-27 text-center ellipsis-nowrap">{{item.name}}</view>
      </view>
    </scroll-view>
  </view>
  <view class="sub-model">
    <view class="sub-title text-black">热门活动</view>
    <view class="sub-more text-grey">查看更多<text class="cuIcon-right text-grey"></text></view>
  </view>
  <view class="col-3-box border-main">
    <view class="col-3-item" qq:for="{{hot}}" wx:if="{{index < 6}}">
      <image src="{{item.face}}"></image>
      <view class="col-3-title text-black text-size-27 text-center">
        {{item.name}}
      </view>
      <view class="col-3-desc text-grey text-size-25 text-center ellipsis-nowrap">{{item.address}}</view>
    </view>
  </view>
  <view class="sub-model">
    <view class="sub-title text-black">最新约行</view>
    <view class="sub-more text-grey">查看更多<text class="cuIcon-right text-grey"></text></view>
  </view>
    <view class="card-box shadow" qq:for="{{hot}}" qq:key qq:for-item="image">
      <view class="card-img imgurl" style="background-image: url({{image.face}})"></view>
      <view class="card-info">
        <view class="card-title margin-top-10">
          <view>{{image.name}}</view>
          <text class="cuIcon-more padding-10 border-box text-grey text-size-30"></text>
        </view>
        <view class="flex-row ">
          <view class="text-grey  text-size-20">
            {{image.info}}
          </view>
        </view>
        <view class="margin-top-10 star-box flex-row">
          <image class="margin-left-5" src="/imgs/source/star-full.png" qq:for="{{5}}"></image>
          <view class="price text-red text-bold">人均 99</view>
        </view>
      </view>
    </view>
</view>
