#!/bin/bash
check_server() {
set_color
echo -e "脚本由${magenta}bilibili:夜辰哒哒哒${none}提供"
echo -e "感谢热心网友提供测试支持!"
if [ -e ${HOME}/mc ]
then
if (whiptail --title "你想对这个小可爱做什么呢？" --yes-button "确定" --no-button '取消' --yesno "检测到您已经部署了基岩版服务器，是否要配置服务器？" 9 50)
then
read_config
configure_server
else start_server
fi
elif (whiptail --title "你想对这个小可爱做什么呢？" --yes-button "确定" --no-button '取消' --yesno "是否部署服务器？" 9 50)
then
check_env
touch_server
depoly_server
read_config
configure_server
start_server
fi
}
check_env() {
echo -e "${green}正在安装相关依赖${none}"
if [ ! $(command -v whiptail) ]
then apt install whiptail -y
fi
if [ ! $(command -v aria2c) ]
then apt install aria2 -y
fi
if [ ! $(command -v unzip) ]
then apt install unzip -y
fi
}
depoly_server() {
VERSION=$(whiptail --title "你想对这个小可爱做什么呢" --menu "选择服务器版本" 0 50 0 \
"52" "1.19.10.03" \
"51" "1.19.2.02" \
"50" "1.19.1.01" \
"49" "1.18.32.02" \
"48" "1.18.31.04" \
"47" "1.18.30.04" \
"46" "1.18.12.01" \
"45" "1.18.11.01" \
"44" "1.18.2.03" \
"43" "1.18.1.02" \
"42" "1.18.0.02" \
"41" "1.17.41.01" \
"40" "1.17.40.06" \
"39" "1.17.34.02" \
"38" "1.17.32.02" \
"37" "1.17.11.01" \
"36" "1.17.10.04" \
"35" "1.17.1.01" \
"34" "1.17.0.03" \
"33" "1.16.221.01" \
"32" "1.16.220.02" \
"31" "1.16.210.05" \
"30" "1.16.201.02" \
"29" "1.16.200.02" \
"28" "1.16.101.01" \
"27" "1.16.100.04" \
"26" "1.16.40.02" \
"25" "1.16.20.03" \
"24" "1.16.10.02" \
"23" "1.16.1.02" \
"22" "1.16.0.2" \
"21" "1.14.60.5" \
"20" "1.14.32.1" \
"19" "1.14.30.2" \
"18" "1.14.20.1" \
"17" "1.14.1.4" \
"16" "1.14.0.9" \
"15" "1.13.3.0" \
"14" "1.13.2.0" \
"13" "1.13.1.5" \
"12" "1.13.0.34" \
"11" "1.12.1.1" \
"10" "1.12.0.28" \
"9" "1.11.4.2" \
"8" "1.11.2.1" \
"7" "1.11.1.2" \
"6" "1.11.0.23" \
"5" "1.10.0.7" \
"4" "1.9.0.15" \
"3" "1.8.1.2" \
"2" "1.8.0.24" \
"1" "1.7.0.13" \
3>&1 1>&2 2>&3)
case ${VERSION} in
52)VER="1.19.10.03";;
51)VER="1.19.2.02";;
50)VER="1.19.1.01";;
49)VER="1.18.32.02";;
48)VER="1.18.31.04";;
47)VER="1.18.30.04";;
46)VER="1.18.12.01";;
45)VER="1.18.11.01";;
44)VER="1.18.2.03";;
43)VER="1.18.1.02";;
42)VER="1.18.0.02";;
41)VER="1.17.41.01";;
40)VER="1.17.40.06";;
39)VER="1.17.34.02";;
38)VER="1.17.32.02";;
37)VER="1.17.11.01";;
36)VER="1.17.10.04";;
35)VER="1.17.1.01";;
34)VER="1.17.0.03";;
33)VER="1.16.221.01";;
32)VER="1.16.220.02";;
31)VER="1.16.210.05";;
30)VER="1.16.201.02";;
29)VER="1.16.200.02";;
28)VER="1.16.101.01";;
27)VER="1.16.100.04";;
26)VER="1.16.40.02";;
25)VER="1.16.20.03";;
24)VER="1.16.10.02";;
23)VER="1.16.1.02";;
22)VER="1.16.0.2";;
21)VER="1.14.60.5";;
20)VER="1.14.32.1";;
19)VER="1.14.30.2";;
18)VER="1.14.20.1";;
17)VER="1.14.1.4";;
16)VER="1.14.0.9";;
15)VER="1.13.3.0";;
14)VER="1.13.2.0";;
13)VER="1.13.1.5";;
12)VER="1.13.0.34";;
11)VER="1.12.1.1";;
10)VER="1.12.0.28";;
9)VER="1.11.4.2";;
8)VER="1.11.2.1";;
7)VER="1.11.1.2";;
6)VER="1.11.0.23";;
5)VER="1.10.0.7";;
4)VER="1.9.0.15";;
3)VER="1.8.1.2";;
2)VER="1.8.0.24";;
1)VER="1.7.0.13";;
esac
mkdir ${HOME}/mc
echo -e "${green}正在下载服务端,请保持网络通畅${none}"
aria2c --console-log-level=warn --no-conf -d "${HOME}/mc/" --allow-overwrite=true -o "mc.zip" "https://minecraft.azureedge.net/bin-linux/bedrock-server-${VER}.zip"
echo -e "${green}正在解压${none}"
unzip -q -d ${HOME}/mc/ ${HOME}/mc/mc.zip
rm ${HOME}/mc/mc.zip
chmod +x ${HOME}/mc/bedrock_server
cat > ${HOME}/mc/server.properties << EOF
server-name=Dedicated Server
gamemode=survival
difficulty=easy
allow-cheats=false
max-players=10
online-mode=true
white-list=false
server-port=19132
server-portv6=19133
view-distance=32
tick-distance=4
player-idle-timeout=30
max-threads=8
level-name=Bedrock level
level-seed=
default-player-permission-level=member
texturepack-required=false
content-log-file-enabled=false
compression-threshold=1
server-authoritative-movement=server-auth
player-movement-score-threshold=20
player-movement-distance-threshold=0.3
player-movement-duration-threshold-in-ms=500
correct-player-movement=false
server-authoritative-block-breaking=false
EOF
}
touch_server() {
touch /usr/bin/mc
>/usr/bin/mc
cat >> /usr/bin/mc << \EOF
#!/bin/bash
green='\e[92m'
none='\e[0m'
echo -e "${green}三连+关注是UP更新的最大动力${none}"
echo -e "${green}https://b23.tv/RYz2u2${none}"
case "$1" in
s | start)
cd ${HOME}/mc
LD_PRELOAD= ./bedrock_server
;;
c | configure)
. <(curl -L https://kindyear1.coding.net/p/my/d/mc/git/raw/master/mc)
;;
h* | H*)
echo -e "你可以输入${green}mc${none}打开菜单"
echo -e "你可以输入${green}mc s${none}或${green}mc start${none}来启动mc基岩版服务器"
echo -e "你可以输入${green}mc c${none}或${green}mc configure${none}来配置mc基岩版服务器"
;;
*)
MENU=$(whiptail --title "菜单" --menu "你想对这个小可爱做什么呢?" 0 50 0 \
"1" "启动服务器" \
"2" "配置服务器" \
"3" "帮助" \
3>&1 1>&2 2>&3)
case ${MENU} in
1)
cd ${HOME}/mc
LD_PRELOAD= ./bedrock_server
;;
2)
. <(curl -L https://kindyear1.coding.net/p/my/d/mc/git/raw/master/mc)
;;
3)
echo -e "你可以输入${green}mc${none}打开菜单"
echo -e "你可以输入${green}mc s${none}或${green}mc start${none}来启动mc基岩版服务器"
echo -e "你可以输入${green}mc c${none}或${green}mc configure${none}来配置mc基岩版服务器"
;;
esac
;;
esac
EOF
chmod 775 /usr/bin/mc
echo -e "你可以输入${green}mc${none}打开菜单"
echo -e "你可以输入${green}mc s${none}或${green}mc start${none}来启动mc基岩版服务器"
echo -e "你可以输入${green}mc c${none}或${green}mc configure${none}来配置mc基岩版服务器"
}
configure_server() {
SECTION=$(whiptail --title "配置服务器" --menu "你想修改哪个配置？" 0 50 0 \
"00" "退出" \
"0" "启动服务器" \
"1" "服务器名称:${CONFIG01}" \
"2" "新玩家游戏模式:${CONFIG02}" \
"3" "设定世界的难度:${CONFIG03}" \
"4" "使用类似命令的作弊手段:${CONFIG04}" \
"5" "同时在线的最大玩家数:${CONFIG05}" \
"6" "Xbox Live 身份验证:${CONFIG06}" \
"7" "白名单模式:${CONFIG07}" \
"8" "IPv4端口:${CONFIG08}" \
"9" "IPv6端口:${CONFIG09}" \
"10" "最大视距:${CONFIG10}" \
"11" "加载区块的距离:${CONFIG11}" \
"12" "挂机玩家被踢出的时间:${CONFIG12}" \
"13" "服务端使用的最大线程数:${CONFIG13}" \
"14" "世界名称&文件夹名:${CONFIG14}" \
"15" "地图种子:${CONFIG15}" \
"16" "新玩家的游戏权限:${CONFIG16}" \
"17" "强制客户端加载服务端资源包:${CONFIG17}" \
"18" "错误内容记录到日志文件中:${CONFIG18}" \
"19" "要压缩的原始网络有效负载的最小大小:${CONFIG19}" \
"20" "服务端权威性移动:${CONFIG20}" \
"21" "player-movement-score-threshold:${CONFIG21}" \
"22" "player-movement-distance-threshold:${CONFIG22}" \
"23" "player-movement-duration-threshold-in-ms:${CONFIG23}" \
"24" "correct-player-movement:${CONFIG24}" \
"25" "服务端权威性挖掘:${CONFIG25}" \
3>&1 1>&2 2>&3)
case ${SECTION} in
00)
;;
0)
start_server
;;
1)
config_01
;;
2)
config_02
;;
3)
config_03
;;
4)
config_04
;;
5)
config_05
;;
6)
config_06
;;
7)
config_07
;;
8)
config_08
;;
9)
config_09
;;
10)
config_10
;;
11)
config_11
;;
12)
config_12
;;
13)
config_13
;;
14)
config_14
;;
15)
config_15
;;
16)
config_16
;;
17)
config_17
;;
18)
config_18
;;
19)
config_19
;;
20)
config_20
;;
21)
config_21
;;
22)
config_22
;;
23)
config_23
;;
24)
config_24
;;
25)
config_25
;;
esac
}
start_server() {
if (whiptail --title "确定启动服务器" --yes-button "确定" --no-button '取消' --yesno "确定启动服务器" 9 50)
then
echo -e "${green}三连+关注是UP更新的最大动力${none}"
echo -e "${green}https://b23.tv/RYz2u2${none}"
echo -e "${green}服务器启动中...${none}"
cd ${HOME}/mc
./bedrock_server
else echo 你取消了操作
fi
}
set_color() {
magenta='\e[95m'
green='\e[92m'
none='\e[0m'
}
read_config() {
echo -e "${green}加载中,请稍候${none}"
TMP=${HOME}/mc/tmp
CONFIG=${HOME}/mc/server.properties
if [ ! -e ${TMP} ]
then touch ${TMP}
fi
CONFIG01=$(sed -n '1,1p' ${CONFIG})
echo ${CONFIG01#*=} > ${TMP}
CONFIG01=$(sed -n '1,1p' ${TMP})
CONFIG02=$(sed -n '2,2p' ${CONFIG})
echo ${CONFIG02#*=} > ${TMP}
CONFIG02=$(sed -n '1,1p' ${TMP})
CONFIG03=$(sed -n '3,3p' ${CONFIG})
echo ${CONFIG03#*=} > ${TMP}
CONFIG03=$(sed -n '1,1p' ${TMP})
CONFIG04=$(sed -n '4,4p' ${CONFIG})
echo ${CONFIG04#*=} > ${TMP}
CONFIG04=$(sed -n '1,1p' ${TMP})
CONFIG05=$(sed -n '5,5p' ${CONFIG})
echo ${CONFIG05#*=} > ${TMP}
CONFIG05=$(sed -n '1,1p' ${TMP})
CONFIG06=$(sed -n '6,6p' ${CONFIG})
echo ${CONFIG06#*=} > ${TMP}
CONFIG06=$(sed -n '1,1p' ${TMP})
CONFIG07=$(sed -n '7,7p' ${CONFIG})
echo ${CONFIG07#*=} > ${TMP}
CONFIG07=$(sed -n '1,1p' ${TMP})
CONFIG08=$(sed -n '8,8p' ${CONFIG})
echo ${CONFIG08#*=} > ${TMP}
CONFIG08=$(sed -n '1,1p' ${TMP})
CONFIG09=$(sed -n '9,9p' ${CONFIG})
echo ${CONFIG09#*=} > ${TMP}
CONFIG09=$(sed -n '1,1p' ${TMP})
CONFIG10=$(sed -n '10,10p' ${CONFIG})
echo ${CONFIG10#*=} > ${TMP}
CONFIG10=$(sed -n '1,1p' ${TMP})
CONFIG11=$(sed -n '11,11p' ${CONFIG})
echo ${CONFIG11#*=} > ${TMP}
CONFIG11=$(sed -n '1,1p' ${TMP})
CONFIG12=$(sed -n '12,12p' ${CONFIG})
echo ${CONFIG12#*=} > ${TMP}
CONFIG12=$(sed -n '1,1p' ${TMP})
CONFIG13=$(sed -n '13,13p' ${CONFIG})
echo ${CONFIG13#*=} > ${TMP}
CONFIG13=$(sed -n '1,1p' ${TMP})
CONFIG14=$(sed -n '14,14p' ${CONFIG})
echo ${CONFIG14#*=} > ${TMP}
CONFIG14=$(sed -n '1,1p' ${TMP})
CONFIG15=$(sed -n '15,15p' ${CONFIG})
echo ${CONFIG15#*=} > ${TMP}
CONFIG15=$(sed -n '1,1p' ${TMP})
CONFIG16=$(sed -n '16,16p' ${CONFIG})
echo ${CONFIG16#*=} > ${TMP}
CONFIG16=$(sed -n '1,1p' ${TMP})
CONFIG17=$(sed -n '17,17p' ${CONFIG})
echo ${CONFIG17#*=} > ${TMP}
CONFIG17=$(sed -n '1,1p' ${TMP})
CONFIG18=$(sed -n '18,18p' ${CONFIG})
echo ${CONFIG18#*=} > ${TMP}
CONFIG18=$(sed -n '1,1p' ${TMP})
CONFIG19=$(sed -n '19,19p' ${CONFIG})
echo ${CONFIG19#*=} > ${TMP}
CONFIG19=$(sed -n '1,1p' ${TMP})
CONFIG20=$(sed -n '20,20p' ${CONFIG})
echo ${CONFIG20#*=} > ${TMP}
CONFIG20=$(sed -n '1,1p' ${TMP})
CONFIG21=$(sed -n '21,21p' ${CONFIG})
echo ${CONFIG21#*=} > ${TMP}
CONFIG21=$(sed -n '1,1p' ${TMP})
CONFIG22=$(sed -n '22,22p' ${CONFIG})
echo ${CONFIG22#*=} > ${TMP}
CONFIG22=$(sed -n '1,1p' ${TMP})
CONFIG23=$(sed -n '23,23p' ${CONFIG})
echo ${CONFIG23#*=} > ${TMP}
CONFIG23=$(sed -n '1,1p' ${TMP})
CONFIG24=$(sed -n '24,24p' ${CONFIG})
echo ${CONFIG24#*=} > ${TMP}
CONFIG24=$(sed -n '1,1p' ${TMP})
CONFIG25=$(sed -n '25,25p' ${CONFIG})
echo ${CONFIG25#*=} > ${TMP}
CONFIG25=$(sed -n '1,1p' ${TMP})
case ${CONFIG02} in
survival)
CONFIG02=生存
;;
creative)
CONFIG02=创造
;;
adventure)
CONFIG02=冒险
;;
esac
case ${CONFIG03} in
peaceful)
CONFIG03=和平
;;
easy)
CONFIG03=简单
;;
normal)
CONFIG03=普通
;;
hard)
CONFIG03=困难
;;
esac
case ${CONFIG04} in
true)
CONFIG04=启用
;;
false)
CONFIG04=禁用
;;
esac
case ${CONFIG06} in
true)
CONFIG06=启用
;;
false)
CONFIG06=禁用
;;
esac
case ${CONFIG07} in
true)
CONFIG07=启用
;
