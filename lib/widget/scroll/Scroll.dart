///可滚动组件都直接或间接包含一个Scrollable组件，因此它们包括一些共同的属性

///axisDirection滚动方向。

///physics：此属性接受一个ScrollPhysics类型的对象，
//它决定可滚动组件如何响应用户操作，比如用户滑动完抬起手指后，继续执行动画；或者滑动到边界时，如何显示
//ClampingScrollPhysics：Android下微光效果。
//BouncingScrollPhysics：iOS下弹性效果。

///controller：此属性接受一个ScrollController对象。
//ScrollController的主要作用是控制滚动位置和监听滚动事件。
//Widget树中会有一个默认的PrimaryScrollController，如果子树中的可滚动组件没有显式的指定controller，
// 并且primary属性值为true时（默认就为true），可滚动组件会使用这个默认的PrimaryScrollController。
// 这种机制带来的好处是父组件可以控制子树中可滚动组件的滚动行为



///Scrollbar是一个Material风格的滚动指示器（滚动条），
//如果要给可滚动组件添加滚动条，只需将Scrollbar作为可滚动组件的任意一个父级组件即可
///CupertinoScrollbar是iOS风格的滚动条


///ViewPort（视口），如无特别说明，则是指一个Widget的实际显示区域

/// 当Sliver出现在视口中时才会去构建它，这种模型也称为“基于Sliver的延迟构建模型”。
//可滚动组件中有很多都支持基于Sliver的延迟构建模型，如ListView、GridView，但是也有不支持该模型的，如SingleChildScrollView。
