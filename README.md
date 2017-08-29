# checkcode
此脚本用来扫描工程中的代码文件，看是否包含特殊标记的注释 //@fix 若有则执行报错

# 用法
- 拷贝check_code.sh 到你工程中
- 修改脚本权限
```sudo chmod 744 check_code.sh```
- 在工程编译过程的某个适当点执行此脚本
```./check_code.sh Release```
或
```./check_code.sh Debug```
若传Debug实际脚本不起作用
