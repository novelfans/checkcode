
#!/bin/sh

echo 当前路径为：`pwd`
suffix="m swift mm js html java"     #文件后缀 空格隔开
pid="$$"    #进程PID号
word="@fix"     #待检测的关键词 即检测到代码中包含@fix则报错

if [ "${CONFIGURATION}" == "Debug" -o "$1" == "Debug" ]; then
    #只有Xcode环境才有CONFIGURATION这个变量 其他环境需用"$1" == "Debug" 来判断
    # 其他环境这样调用这个脚本: ./xxx.sh Release 或 ./xxx.sh Debug
    echo "Debug不检测退出..."
    exit 0
fi

echo "==========================================错误信息=========================================="
#以进程PID命名临时文件
T="tmp_${pid}.txt"

#按ctrl+c中断后 删除临时文件 然后正常退出
trap '{rm -f $T; exit 0;}' INT

for s in $suffix
do
    paths=`find . -iname "*.$s"`
    echo "$paths" > $T


    while read line
    do
        if [ ${#line} -gt 0 ]; then
        ret=`grep -i "$word" "$line"`
        if [ ${#ret} -gt 0 ]; then
            echo -e "`basename $line`: $ret"
            needOpen=1
        fi
    fi
    done < $T
done

rm -f $T
if [ $needOpen -eq 1 ]; then
    echo "==========================================错误信息=========================================="
    exit 1
fi



