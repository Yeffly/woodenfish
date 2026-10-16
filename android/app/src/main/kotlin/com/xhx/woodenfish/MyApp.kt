package com.xhx.woodenfish

import android.app.Application

class MyApp : Application() {
    override fun onCreate() {
        super.onCreate()
        // 移除友盟UMConfigure初始化代码
    }
}
