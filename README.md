# 感應式酒精消毒器
## 系統功能與原理
* 系統功能：
使用超音波感應距離，當手靠近時，馬達帶動板子移開，滴出酒精。

* 原理說明：
超音波trig傳出聲波後，當echo接收到時，echo的pin腳變成1，啟動timer1開始計時，將時間換算成距離，距離夠短時將RD0設成1，並透過杜邦線連到馬達所接pic18f的RD0，偵測到RD0為1，啟動馬達並轉動板子，滴出酒精。

## 使用環境及對象
* 使用環境：
住宅、學校與商店等皆可，作為手部消毒使用。

* 對象：
需要酒精消毒的群眾。

## 系統完整架構圖、流程圖、電路圖、設計
* 架構圖：

![image](https://github.com/sherry891220/Automatic-sanitizer-dispenser/blob/main/image/image1.png)
* 流程圖：

![image](https://github.com/sherry891220/Automatic-sanitizer-dispenser/blob/main/image/image2.jpg)
* 電路圖：

![image](https://github.com/sherry891220/Automatic-sanitizer-dispenser/blob/main/image/image3.png)

## 系統開發工具、材料及技術
* 開發工具：
MPLab，超音波使用C撰寫，馬達使用Assembly撰寫。

* 材料：
1個超音波、2個pic18f、2個燒錄器、1個馬達、數條杜邦線、1個LED及電阻、1個酒精盒。

* 技術：
用超音波啟動馬達。

## 周邊接口說明
* 超音波：
VCC接正電位，TRIG接RA0，ECHO接RA1，GND接負電位。

* 馬達：
橘線接CCP1，紅線接正電位，棕線接負電位。

## 遇到的困難及如何解決
* 困難1：
這次使用的超音波沒有在課堂上使用過，所以一開始不知道如何撰寫程式。

  解決辦法1：
只能透過上網查詢相關資料，多加嘗試。

* 困難2:
杜邦線常常會接觸不良。

  解決辦法2：
盡量減少杜邦線延長連接的情況，降低接觸不量的機率。

* 困難3:
馬達力道不足，無法擠壓酒精瓶。

  解決辦法3：
改成將酒精瓶戳洞，馬達上貼著板子堵住酒精瓶的洞口，馬達轉動帶動板子移開，使酒精瓶順利滴出酒精。

## 單元項目
* TIMER：
  * TIMER1：用來計算超音波的距離。
  * TIMER2：用在PWM Mode的計數。

* PWM：
控制馬達轉動。

## 進階單元項目
* 超音波：
用來感應使用者的手與裝置之距離，距離小於一定程度時，馬達轉動。
