<!--<navbar  is_home="{{true}}" title="南阳理工学院"></navbar>-->
<!--<header activekey="home"></header>-->
<view class="home-container"  animation="{{slide_up1}}">
    <view class="space-between top">
        <view class="location" qq:if="{{schools}}">
            <picker bindchange="bindPickerChange" range-key='name' range="{{schools}}">
                <text class="cuIcon-locationfill"></text>
                <text class="margin-left-10">{{choose_value}}</text>
                <text class="cuIcon-right margin-left-10"></text>
            </picker>
        </view>
        <view class="auto-left margin-right-10 text-size-23" qq:if="{{temp}}">
            <view class="flex-column margin-left-10">
                <view class="auto-left flex-row">
                    <text>{{temp.province}}{{temp.name}} · {{temp.day_op}}</text>
                    <text class="margin-left-10">{{temp.tem}}°C</text>
                </view>
                <view class="text-right text-size-20 margin-top-5">
                    <text>{{temp.last_update}}</text>
                    <text class="margin-left-10">更新</text>
                </view>
            </view>
        </view>
    </view>
    <swiper-slider bind:myevent="ChildClick" swiper-data="{{banners}}" swiper-options="{{swiperOptions}}"></swiper-slider>
    <view class="weui-grids">
        <view class="weui-grid  init " qq:for="{{icons}}" qq:key="{{item.id}}"  bindtap="HandleClick" data-url="{{item.url}}">
                <view class='weui-grid__bg'>
                    <view class="weui-grid__icon">
                        <image src="{{item.src}}" mode="scaleToFill" mode="aspectFill"></image>
                    </view>
                    <text class="weui-grid__label">{{item.name}}</text>
                </view>
        </view>
    </view>
</view>
