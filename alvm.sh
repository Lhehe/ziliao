#!/bin/bash
read -p "创建lVM输入1，删除输入2:" number
if [ $number -eq 1 ];then
array_str=()
read -p "输入你要加入几块磁盘" num
for((i=0;i<$num;i++));
do
    read -p "请输入你想要个格式化的磁盘:"  array_str[i]
done
echo "正在创建叫做VolGroup的逻辑卷组"
pvcreate /dev/${array_str[0]}
vgcreate VolGroup /dev/${array_str[0]}
for((i=1;i<$num;i++));
do
pvcreate /dev/${array_str[i]}
vgextend VolGroup /dev/${array_str[i]}
done
Free_PE=`vgdisplay | grep "Free" | awk '{print $5}'`
echo "正在创建名为lv01的卷"
lvcreate -Zn -n lv01 -l +$Free_PE VolGroup
LV_Path=`lvdisplay | grep "LV Path" | awk '{print $3}'`
echo "请把 $LV_Path 格式化挂载使用,谢谢！！"
else 
	
  	lvremove /dev/VolGroup/lv01
	vgremove VolGroup
	m=(`pvscan | grep "PV" | awk '{print $2}'`)
	ms=${#m[@]}
	for ((i=0;i<=$ms;i++));
	do
	pvremove ${m[i]} 2> /dev/null
	done
	
fi


