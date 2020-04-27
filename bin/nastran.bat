@ECHO OFF
SETLOCAL

set "NASTRANEXE=%~dp0nastran.exe"
set "CURDIR=%CD%"

call:getDIRCTY

for %%A in ("%~dp0..") do set "RFDIR=%%~dpfxA\rf"

:parseArgs
:: asks for the outdir argument and store the value in the variable OUTDIR
call:getArgWithValue "outdir" "OUTDIR" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the nptpnm argument and store the value in the variable NPTPNM
call:getArgWithValue "nptpnm" "NPTPNM" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the pltnm argument and store the value in the variable PLTNM
call:getArgWithValue "pltnm" "PLTNM" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the dictnm argument and store the value in the variable DICTNM
call:getArgWithValue "dictnm" "DICTNM" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the punchnm argument and store the value in the variable PUNCHNM
call:getArgWithValue "punchnm" "PUNCHNM" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the optpnm argument and store the value in the variable OPTPNM
call:getArgWithValue "optpnm" "OPTPNM" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the lognm argument and store the value in the variable LOGNM
call:getArgWithValue "lognm" "LOGNM" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the f06 argument and store the value in the variable F06
call:getArgWithValue "f06" "F06" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the in12 argument and store the value in the variable IN12
call:getArgWithValue "in12" "IN12" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the out11 argument and store the value in the variable OUT11
call:getArgWithValue "out11" "OUT11" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the ftn11 argument and store the value in the variable FTN11
call:getArgWithValue "ftn11" "FTN11" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the ftn12 argument and store the value in the variable FTN12
call:getArgWithValue "ftn12" "FTN12" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the ftn13 argument and store the value in the variable FTN13
call:getArgWithValue "ftn13" "FTN13" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the ftn14 argument and store the value in the variable FTN14
call:getArgWithValue "ftn14" "FTN14" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the ftn15 argument and store the value in the variable FTN15
call:getArgWithValue "ftn15" "FTN15" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the ftn16 argument and store the value in the variable FTN16
call:getArgWithValue "ftn16" "FTN16" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the ftn17 argument and store the value in the variable FTN17
call:getArgWithValue "ftn17" "FTN17" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the ftn18 argument and store the value in the variable FTN18
call:getArgWithValue "ftn18" "FTN18" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the ftn19 argument and store the value in the variable FTN19
call:getArgWithValue "ftn19" "FTN19" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the ftn20 argument and store the value in the variable FTN20
call:getArgWithValue "ftn20" "FTN120" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the ftn21 argument and store the value in the variable FTN21
call:getArgWithValue "ftn21" "FTN21" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the sof1 argument and store the value in the variable SOF1
call:getArgWithValue "sof1" "SOF1" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the sof2 argument and store the value in the variable SOF2
call:getArgWithValue "sof2" "SOF2" "%~1" "%~2" && shift && shift && goto :parseArgs

:: asks for the dbmem argument and store the value in the variable DBMEM
call:getArgWithValue "dbmem" "DBMEM" "%~1" "%~2" "i" && shift && shift && goto :parseArgs

:: asks for the ocmem argument and store the value in the variable OCMEM
call:getArgWithValue "ocmem" "OCMEM" "%~1" "%~2" "i" && shift && shift && goto :parseArgs

if "%OUTDIR%"=="" (
    set "OUTDIR=%CURDIR%"
)

set "PROBNAME=%OUTDIR%\%~n1"

if "%NPTPNM%"=="" (
    set "NPTPNM=%PROBNAME%.nptp"
)

if "%PLTNM%"=="" (
    set "PLTNM=%PROBNAME%.plt"
)

if "%DICTNM%"=="" (
    set "DICTNM=%PROBNAME%.dict"
)

if "%PUNCHNM%"=="" (
    set "PUNCHNM=%PROBNAME%.pch"
)

if "%OPTPNM%"=="" (
    set "OPTPNM=%PROBNAME%.opt"
)

if "%LOGNM%"=="" (
    set "LOGNM=%PROBNAME%.f04"
)

if "%F06%"=="" (
    set "F06=%PROBNAME%.f06"
)

if "%IN12%"=="" (
    set "IN12=%PROBNAME%.in12"
)

if "%OUT11%"=="" (
    set "OUT11=%PROBNAME%.out11"
)

if "%FTN11%"=="" (
    set "FTN11=%PROBNAME%.f11"
)

if "%FTN12%"=="" (
    set "FTN12=%PROBNAME%.f12"
)

if "%FTN13%"=="" (
    set "FTN13=%PROBNAME%.f13"
)

if "%FTN14%"=="" (
    set "FTN14=%PROBNAME%.f14"
)

if "%FTN15%"=="" (
    set "FTN15=%PROBNAME%.f15"
)

if "%FTN16%"=="" (
    set "FTN16=%PROBNAME%.f16"
)

if "%FTN17%"=="" (
    set "FTN17=%PROBNAME%.f17"
)

if "%FTN18%"=="" (
    set "FTN18=%PROBNAME%.f18"
)

if "%FTN19%"=="" (
    set "FTN19=%PROBNAME%.f19"
)

if "%FTN20%"=="" (
    set "FTN20=%PROBNAME%.f20"
)

if "%FTN21%"=="" (
    set "FTN21=%PROBNAME%.f21"
)

if "%DBMEM%"=="" (
    set "DBMEM=12000000"
)

if "%OCMEM%"=="" (
    set "OCMEM=2000000"
)

for %%A in ("%~1") do set "INPUT=%%~dpfxA"

MKDIR "%DIRCTY%"
CHDIR /D "%DIRCTY%"
"%NASTRANEXE%" "" < "%INPUT%" > "%F06%"
CHDIR /D "%CURDIR%"
RMDIR /Q /S "%DIRCTY%"

ENDLOCAL
goto:eof

:: =====================================================================
:: This function generates temporary directory
:getDIRCTY
set /a "DIRCTY=%RANDOM%+100000"
set "DIRCTY=%TMP%\Tmp%DIRCTY:~-5%.TMP"
if exist %DIRCTY% goto :getDIRCTY
exit /B 0
goto:eof

:: =====================================================================
:: This function sets a variable from a cli arg with value
:: 1 cli argument name
:: 2 variable name
:: 3 current Argument Name
:: 4 current Argument Value
:getArgWithValue
if "%~3"=="%~1" (
  if "%~4"=="" (
    REM unset the variable if value is not provided
    set "%~2="
    exit /B 1
  )
  if "%~5" equ "i" (
    set "%~2=%~4"
  ) else (
    for %%A in ("%~4") do set "%~2=%%~dpfxA"
  )
  exit /B 0
)
exit /B 1
goto:eof
