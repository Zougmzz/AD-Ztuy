@echo off
setlocal enabledelayedexpansion

rem 设置字符编码
chcp 65001 >nul

rem 设置原始文件和临时文件路径
set "tempFile=data\temp.txt"
set "shidFile=data\待审核UID.txt"
set "uidFile=data\UID名单.txt"
set "schaFile=审查.txt"

rem 检查原始文件是否存在
if not exist "%shidFile%" (
    echo 文件不存在: %shidFile%
    exit /b 1
)

rem 创建空的临时文件
copy nul "%tempFile%" >nul

rem 遍历原始文件的每一行
for /f "delims=" %%a in (%shidFile%) do (
    set "line=%%a"
    
    rem 检查临时文件中是否已存在相同的行，如果不存在则追加到临时文件
    findstr /x "!line!" "%tempFile%" >nul || echo !line!>> "%tempFile%"
)

rem 将临时文件的内容覆盖回原始文件
move /y "%tempFile%" "%shidFile%" >nul

echo 从 %shidFile% 中删除了重复行

rem 检查文件是否存在
if not exist "%shidFile%" (
    echo 待审核UID.txt 文件不存在.
    exit /b
)

if not exist "%uidFile%" (
    echo UID名单.txt 文件不存在.
    exit /b
)

rem 清空临时文件
type nul > "%tempFile%"

for /f "delims=" %%a in (%shidFile%) do (
    set "ddidLine=%%a"
    findstr /x "!ddidLine!" "%uidFile%" >nul || (
        echo !ddidLine!>>"%tempFile%"
    )
)

rem 复制临时文件内容回到DDID.txt
copy "%tempFile%" "%shidFile%" /y

rem 删除临时文件
del "%tempFile%"

rem 检查DDID.txt文件是否存在
if not exist "%shidFile%" (
    echo 待审核UID.txt 文件不存在.
    exit /b
)

rem 清空或创建审查.txt文件
type nul > "%schaFile%"

rem 遍历DDID.txt文件的每一行，将每一行的数字组合写入审查.txt文件
for /f "delims=" %%a in (%shidFile%) do (
    set "ddidLine=%%a"
    echo https://space.bilibili.com/!ddidLine!>> "%schaFile%"
)

echo UID已写入审查.txt文件.

endlocal

