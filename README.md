# XYPlateRecognizeUtil + RealTime

基于 [XYPlateRecognizeUtil](https://github.com/levinXiao/XYPlateRecognizeUtil) 改进的,增加了实时识别车牌号的功能.

# easyPR介绍
EasyPR是一个中文的开源车牌识别系统,其目标是成为一个简单、灵活、准确的车牌识别引擎。

相比于其他的车牌识别系统，EasyPR有如下特点：

* 它基于openCV这个开源库。这意味着你可以获取全部源代码，并且移植到opencv支持的所有平台。
* 它能够识别中文。例如车牌为苏EUK722的图片，它可以准确地输出std:string类型的"苏EUK722"的结果。
* 它的识别率较高。图片清晰情况下，车牌检测与字符识别可以达到80%以上的精度。

最重要的是 这个是由**国人**开源的

[easyPR github地址](https://github.com/liuruoze/EasyPR)

后来又有一个**国人** 基于easyPR开发出来基于iOS版本的EasyPR-iOS

[EasyPR-iOS github地址](https://github.com/zhoushiwei/EasyPR-iOS)

XYPlateRecognizeUtil 也是在**EasyPR-iOS**基础上封装 使其易用性更高



