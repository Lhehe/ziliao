#!/bin/bash
read -p "创建lVM输入1，删除输入2:" number
if [ $number -eq 1 ];then
array_str=()
read -p "输入你要加入几块磁盘" num
for((i=0;i<$num;i++));
do
    read -p "请输入你想要个格式化的磁盘"  array_str[i]
done
pvcreate /dev/${array_str[0]}
vgcreate VolGroup00 /dev/${array_str[0]}
for((i=1;i<$num;i++));
do
pvcreate /dev/${array_str[i]}
vgextend VolGroup00 /dev/${array_str[i]}
done
echo "正在创建叫做VolGroup的逻辑卷组"
echo "正在创建名为lv01的卷"
Free_PE=`vgdisplay | grep "Free" | awk '{print $5}'`
lvcreate -l +$Free_PE -n lv01 VolGroup00
LV_Path=`lvdisplay | grep "LV Path" | awk '{print $3}'`
echo "请把 $LV_Path 格式化挂载使用,谢谢！！"
else 
	
  	lvremove /dev/VolGroup00/lv01
	vgremove VolGroup00
	m=(`pvscan | grep "PV" | awk '{print $2}'`)
	ms=${#m[@]}
	for ((i=0;i<=$ms;i++));
	do
	pvremove ${m[i]} 2> /dev/null
	done
	
fi


