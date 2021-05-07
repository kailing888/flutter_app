///在任何系统的UI框架中，动画实现的原理都是相同的，即：在一段时间内，快速地多次改变UI外观；
///由于人眼会产生视觉暂留，所以最终看到的就是一个“连续”的动画，这和电影的原理是一样的。
///一般情况下，对于人眼来说，动画帧率超过16FPS，就比较流畅了，超过32FPS就会非常的细腻平滑，而超过32FPS，人眼基本上就感受不到差别了。
///
///
/// Animation对象是一个在一段时间内依次生成一个区间(Tween)之间值的类。


///Animation来监听动画每一帧以及执行状态的变化，Animation有如下两个方法：

//addListener()；它可以用于给Animation添加帧监听器，在每一帧都会被调用。帧监听器中最常见的行为是改变状态后调用setState()来触发UI重建。
//addStatusListener()；它可以给Animation添加“动画状态改变”监听器；动画开始、结束、正向或反向（见AnimationStatus定义）时会调用状态改变的监听器。

/// Curves (opens new window) 类是一个预置的枚举类，定义了许多常用的曲线
//linear	匀速的
// decelerate	匀减速
// ease	开始加速，后面减速
// easeIn	开始慢，后面快
// easeOut	开始快，后面慢
// easeInOut	开始慢，然后加速，最后再减速

///AnimationController用于控制动画，它包含动画的启动forward()、停止stop() 、反向播放 reverse()等方法。
//默认情况下，AnimationController在给定的时间段内线性的生成从0.0到1.0（默认区间）的数字。
//AnimationController生成数字的区间可以通过lowerBound和upperBound来指定

///Tween
//可以使用Tween来添加映射以生成不同的范围或数据类型的值
///