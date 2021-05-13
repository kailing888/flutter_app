///包管理
///dart包
//pubspec.yaml中:引入
//  flutter_easyrefresh:
//     git:
//       url: 'ssh://git@git.longhu.net:8010/c4app/flutter-lib/easyrefresh.git'
//       ref: '2.1.7'

//path: ../../../longfor_flutter_base/

//flutter_rating_bar: ^3.2.0+1
///插件包
///需要为特定于平台的构建文件添加合适的依赖声明
//android {
//     // lines skipped
//     dependencies {
//         provided rootProject.findProject(":url_launcher")
//     }
// }


//在hello/ios/hello.podspec:
//
// Pod::Spec.new do |s|
//   # lines skipped
//   s.dependency 'url_launcher'
///发布package
//运行 dry-run 命令以查看是否都准备OK了:
//flutter packages pub publish --dry-run
//验证无误后，我们就可以运行发布命令了：
//flutter packages pub publish


///插件开发
///平台通道数据类型支持
//当在发送和接收值时，这些值在消息中的序列化和反序列化会自动进行

//Flutter中提供了一种覆盖默认平台的机制，我们可以通过显式指定debugDefaultTargetPlatformOverride全局变量的值来指定应用平台。
//debugDefaultTargetPlatformOverride=TargetPlatform.iOS;
// print(defaultTargetPlatform); // 会输出TargetPlatform.iOS



