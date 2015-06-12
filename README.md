> 使用自定义手势在项目中开打log输出控制面板

+ 运行项目，在屏幕上左右来回滑动2次以上，即可打开log输出控制面板
+ 在log输出控制面板修改log输出配置后，点击filter即可生效
+ 修改生效后的log输出配置会保持在沙盒中，每次进入app都会使用最新的配置

----

###可以在代码里配置默认的输出控制
+ Type 配置log类型
+ Class 配置打印log的类
+ Contains 配置log中包含的字符

![image](https://github.com/lyxia/DebugLogController/blob/master/1.png)

###log输出控制面板

**筛选打印log的类名效果图**

![image](https://github.com/lyxia/DebugLogController/blob/master/3.png)

**打印log的类名与log类型一起筛选效果图**

![image](https://github.com/lyxia/DebugLogController/blob/master/4.png)