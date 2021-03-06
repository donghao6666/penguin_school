<!--pages/preview/preview.wxml-->
<view class='show-img' style='height:{{system.screenHeight}}px'>
  <view bindtap='back_page' style='height:{{height*2 -48}}px;top:0;left:1em;' class='bar'>
    <text class="{{detail_load?'cuIcon-homefill':'cuIcon-close'}}"></text>
  </view>
  <view class='preview-swiper'>
    <swiper indicator-dots="{{indicatorDots}}" vertical="{{vertical}}" autoplay="{{autoplay}}" duration="{{duration}}" interval='{{interval}}' bindchange="bindchange"  circular="{{circular}}" style="height:{{imgheights[current]}}rpx;">
      <block wx:for='{{gallary.imgs}}' wx:key="{{index}}">
        <swiper-item>
          <image src="{{item}}" data-id='{{index}}' class="slide-image" mode="widthFix" bindload="imageLoad"/>
        </swiper-item>
      </block>
    </swiper>
  </view>
  <view animation="{{animationData}}" class='fix' bindtap='show_all' >
    <view class='interact'>
      <view class='witget'>
        <view>
          <text class="cuIcon-picfill font-size-50"></text>
          <text class="margin-left-20">{{gallary.imgs.length}}</text>
        </view>
        <view bindtap="FavorClick" data-id="{{gallary.id}}"
              data-count="{{gallary.favor_count}}">
          <text class="text-red font-size-50 {{gallary.status=='favor'?' cuIcon-likefill':'cuIcon-like'}}  text-size-30"></text>
          <text class="margin-left-20">{{gallary.favor_count}}</text>
        </view>
        <view>
          <text class="cuIcon-attentionfill font-size-50"></text>
          <text class="margin-left-20">{{gallary.view_count}}</text>
        </view>
        <text class="cuIcon-more font-size-50 border-box padding-10"  bindtap='action_sheet' style='margin-left: 1em;' ></text>
      </view>

      <view class='totop border-box padding-10'>
        <text qq:if="{{!info_show}}" animation="{{topAniData}}" class="font-size-50 cuIcon-fold"></text>
        <text qq:else="{{info_show}}" animation="{{topAniData}}" class="font-size-50 cuIcon-unfold"></text>
      </view>
    </view>
    <view class='info'>
      <view class='text-info'>
        <text class='title'>{{gallary.title}}</text>
        <text class='name'>{{gallary.nickname}} 发布</text>
      </view>

      <view bindtap='go_userpage'  class='user-info'>
        <image src='{{gallary.avatarUrl}}'></image>
      </view>
    </view>
    <view class='img-info' style='height: {{system.screenHeight * 0.2}}px; bottom: -{{system.screenHeight * 0.2}}px'>
      <view>
        <text class="cuIcon-timefill"></text>
        <text class="margin-left-20">{{gallary.create_time}}</text>
      </view>
      <view qq:if="{{gallary.address}}">
        <text class="cuIcon-locationfill"></text>
        <text class="margin-left-20">{{gallary.address}}</text>
      </view>
    </view>
    <!-- img-info end -->
  </view>
  <!-- fix end -->
</view>

<!-- action sheet -->
<action-sheet hidden="{{actionSheetHidden}}" bindchange="action_sheet">
    <action-sheet-item style='margin-top: 0.3em;'  catchtap='save' data-url='{{gallary.imgs}}'>下载</action-sheet-item>
    <action-sheet-item><button style='background-color: #fff; border: none; margin:0' open-type='share'>分享</button></action-sheet-item>
    <action-sheet-cancel >取消</action-sheet-cancel>
</action-sheet>
<!-- action sheet -->
