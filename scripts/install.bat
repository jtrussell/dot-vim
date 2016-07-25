@echo off

rem Hack to get normalized paths
set dir_root=%~dp0\..\
pushd %dir_root%
set dir_root=%CD%
popd

set dir_bundle=%dir_root%\bundle


:main
rem Create the plugins directory
if not exist %dir_bundle% (
  mkdir %dir_bundle%
)

rem Install each plugin listed in vimrc.bundles
for /F "tokens=*" %%A in (%dir_root%\vimrc.bundles) do (
  call :install_or_update_bundle %%A
)

rem Symlink to the vimrc here
call :link_vimrc

rem That's all folks
goto :eof


:install_or_update_bundle
setlocal
set bundle=%1
for /F "tokens=2 delims=/" %%A in ("%bundle%") do (
  set bundle_name=%%A
)

if EXIST %dir_bundle%\%bundle_name% (
  call :update_bundle %bundle_name%
) else (
  call :install_bundle %bundle% %bundle_name%
)
endlocal
goto :eof


:install_bundle
setlocal
set bundle=%1
set bundle_name=%2
set url=https://github.com/%bundle%.git
echo Installing %bundle_name%...
git clone %url% %dir_bundle%\%bundle_name%
endlocal
goto :eof


:update_bundle
setlocal
set bundle_name=%1
pushd %dir_bundle%\%bundle_name%
echo Updating %bundle_name%...
git pull
popd
endlocal
goto :eof


:link_vimrc
setlocal
rem Delete the old vimrc backup
if exist %userprofile%\.vimrc-rescue (
  echo Removing existing vimrc rescue file...
  del %userprofile%\.vimrc-rescue
)

rem Back up the existing vimrc if there is one
if exist %userprofile%\.vimrc (
  echo Backing upexisting vimrc to %userprofile%\.vimrc-rescue...
  move %userprofile%\.vimrc %userprofile%\.vimrc-rescue
)

mklink %userprofile%\.vimrc %dir_root%\vimrc
mklink %dir_root%\init.vim %dir_root%\vimrc
endlocal
goto :eof
