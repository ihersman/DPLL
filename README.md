# DPLL
	纯数字元器件搭建的锁相环，可以精准控制信号延时。
    
## 参数介绍

	module DPLL
	(
    	input         resetn,      //复位

		input         ref_clk,     //参考时钟
		input [15:0]  ref_counter, //参考时钟倍数

		input [ 8:0]  init,        //加速初始化参数
		input [15:0]  counter,     //输出时钟设置参数

		input         clk_in,      //需要延时的信号
		output        clk_out,     //延时后的信号

		output [2:0]  status       //工作状态
	);

## 参数计算
	假设输出延时t  参考时钟周期为T 
	T x ref_counter = 2 x t x counter;  为了提高精度，counter的数值控制在几千。 init = t/0.06 （单位是ns）


## 操作时序
	先resetn=0，然后配置参数，等待毫秒时间，resetn=1 status[3] 为1时表示频率已经锁定，status[1]表示频率设置超出范围 status[0] 为 0 表示 超出最高频率，1表示最低频率。

## 文档介绍
	./src   下为源码   修改top.v的值，make 后可以看波形。

