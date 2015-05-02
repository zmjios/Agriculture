项目架构说明：

1.代码结构分为四个部分，分别为Common_Layer,Deep_Layer,GUI_Layer,Middle_Layer,分别对应如下：
    Common_Layer:一些通用的宏定义和项目常用通用方法封装
    Deep_Layer:项目架构的底层，引用AFnetworing等网络请求库，自定义反射基类等等
    Middle_Layer:业务处理的中间层，例如网络请求的数据分发和model解析类等等
    GUI_Layer:控制器和View的通用类，为方便使用，每一个相对独立的模块新建一个文件夹

