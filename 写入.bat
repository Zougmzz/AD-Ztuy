@echo off
setlocal enabledelayedexpansion

rem 设置字符编码
chcp 65001 >nul

rem 设置文件路径
set "ddidFile=data\待审核UID.txt"
set "uidFile=data\UID名单.txt"
set "gcFile=data\关键词.txt"
set "adzFile=AD-Ztuy.txt"
set "backupFolder=data\backup"

rem 检查文件是否存在
if not exist "%ddidFile%" (
    echo 待审核UID.txt 文件不存在.
    exit /b
)

if not exist "%uidFile%" (
    echo UID名单.txt 文件不存在.
    exit /b
)
if not exist "%gcFile%" (
    echo 关键词.txt 文件不存在.
    exit /b
)

rem 创建备份文件夹（如果不存在）
if not exist "%backupFolder%" (
    mkdir "%backupFolder%"
)

rem 备份UID名单和AD-Ztuy文件到备份文件夹
copy "%uidFile%" "%backupFolder%\UID名单_backup.txt" >nul
copy "%gcFile%" "%backupFolder%\关键词_backup.txt" >nul
copy "%adzFile%" "%backupFolder%\AD-Ztuy_backup.txt" >nul

rem 遍历待审核UID.txt文件的每一行，将其追加到UID名单.txt文件中
for /f "delims=" %%a in (%ddidFile%) do (
    echo %%a>>"%uidFile%"
)

echo 数字组已追加到 UID.txt 文件.

rem 检查UID名单.txt文件是否存在
if not exist "%uidFile%" (
    echo UID名单.txt 文件不存在.
    exit /b
)

rem 清空或创建AD-Ztuy.txt文件
type nul > "%adzFile%"

rem 打印一点分割和提示
echo 更新地址:https://github.com/Zougmzz/AD-Ztuy/blob/papers/AD-Ztuy.txt >> "%adzFile%"

rem 打印一点分割和提示
echo 广告规则:B站 >> "%adzFile%"
echo bilibili.com###i_cecream ^> div.bili-feed4:last-child ^> main.bili-feed4-layout:nth-child(3) ^> div.feed2:last-child ^> div.recommended-container_floor-aside-no-banner ^> div.no-banner-container.is-version8:nth-child(2) ^> div.feed-card:has(.bili-video-card__info--ad) >> "%adzFile%"
echo bilibili.com###i_cecream ^> div.bili-feed4:last-child ^> main.bili-feed4-layout:nth-child(3) ^> div.feed2:last-child ^> div.recommended-container_floor-aside-no-banner ^> div.no-banner-container.is-version8:nth-child(2) ^> div.bili-video-card.is-rcmd:has(.bili-video-card__info--ad) >> "%adzFile%"

rem 打印一点分割和提示
echo UID规则 >> "%adzFile%"

rem 遍历UID名单.txt文件的每一行，将每一行的数字组替换为指定的形式并追加到AD-Ztuy.txt文件
for /f "delims=" %%a in (%uidFile%) do (
    set "uid=%%a"
    set "line=search.bilibili.com###i_cecream ^> div.search-layout.clearfix ^> div:nth-child(2) ^> div.search-content--gray.search-content:last-child ^> div.search-page-wrapper ^> div.search-page.search-page-all ^> div ^> div.video.i_wrapper.search-all-list:nth-child(2) ^> div.video-list.row ^> div.col_3.col_xs_1_5.col_md_2.col_xl_1_7.mb_x40:has(a.bili-video-card__info--owner[href*="!uid!"])"
    echo !line!>> "%adzFile%"
	set "line=search.bilibili.com###i_cecream ^> div.search-layout.clearfix ^> div:nth-child(2) ^> div.search-content--gray.search-content:last-child ^> div.search-page-wrapper ^> div.search-page.search-page-video.i_wrapper.mt_xxl.pb_xxl ^> div.video-list.row:first-child ^> div.video-list-item.col_3.col_xs_1_5.col_md_2.col_xl_1_7.mb_x40:has(a.bili-video-card__info--owner[href*="!uid!"])"
    echo !line!>> "%adzFile%"
    set "line=bilibili.com###i_cecream ^> div.bili-feed4:last-child ^> main.bili-feed4-layout:nth-child(3) ^> div.feed2:last-child ^> div.recommended-container_floor-aside-no-banner ^> div.no-banner-container.is-version8:nth-child(2) ^> div.feed-card:has(a.bili-video-card__info--owner[href*="!uid!"])"
    echo !line!>> "%adzFile%"
	set "line=bilibili.com###i_cecream ^> div.bili-feed4:last-child ^> main.bili-feed4-layout:nth-child(3) ^> div.feed2:last-child ^> div.recommended-container_floor-aside-no-banner ^> div.no-banner-container.is-version8:nth-child(2) ^> div.bili-video-card.is-rcmd:has(a.bili-video-card__info--owner[href*="!uid!"])"
    echo !line!>> "%adzFile%"
	
    set "line=bilibili.com###comment ^> div.comment ^> div.bili-comment.browser-pc ^> div.comment-container ^> div.reply-warp:last-child ^> div.reply-list:last-child ^> div.reply-item:has(div.user-name[data-user-id*="!uid!"])"
    echo !line!>> "%adzFile%"
)

rem 打印一点分割和提示
echo 关键词规则 >> "%adzFile%"

rem 遍历关键词.txt文件的每一行，将每一行的关键字替换为指定的形式并追加到AD-Ztuy.txt文件
for /f "delims=" %%a in (%gcFile%) do (
    set "gc=%%a"
    set "line=search.bilibili.com###i_cecream ^> div.search-layout.clearfix ^> div:nth-child(2) ^> div.search-content--gray.search-content:last-child ^> div.search-page-wrapper ^> div.search-page.search-page-all ^> div ^> div.video.i_wrapper.search-all-list:nth-child(2) ^> div.video-list.row ^> div.col_3.col_xs_1_5.col_md_2.col_xl_1_7.mb_x40:has(h3.bili-video-card__info--tit[title*="!gc!"])"
    echo !line!>> "%adzFile%"
	set "line=search.bilibili.com###i_cecream ^> div.search-layout.clearfix ^> div:nth-child(2) ^> div.search-content--gray.search-content:last-child ^> div.search-page-wrapper ^> div.search-page.search-page-video.i_wrapper.mt_xxl.pb_xxl ^> div.video-list.row:first-child ^> div.video-list-item.col_3.col_xs_1_5.col_md_2.col_xl_1_7.mb_x40:has(h3.bili-video-card__info--tit[title*="!gc!"])"
    echo !line!>> "%adzFile%"
    set "line=bilibili.com###i_cecream ^> div.bili-feed4:last-child ^> main.bili-feed4-layout:nth-child(3) ^> div.feed2:last-child ^> div.recommended-container_floor-aside-no-banner ^> div.no-banner-container.is-version8:nth-child(2) ^> div.feed-card:has(h3.bili-video-card__info--tit[title*="!gc!"])"
    echo !line!>> "%adzFile%"
	set "line=bilibili.com###i_cecream ^> div.bili-feed4:last-child ^> main.bili-feed4-layout:nth-child(3) ^> div.feed2:last-child ^> div.recommended-container_floor-aside-no-banner ^> div.no-banner-container.is-version8:nth-child(2) ^> div.bili-video-card.is-rcmd:has(h3.bili-video-card__info--tit[title*="!gc!"])"
    echo !line!>> "%adzFile%"
)

echo UID已写入AD-Ztuy.txt文件.

endlocal