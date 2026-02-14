@echo off
setlocal

REM Run compiler (serious's compiler)
"C:\t7compiler\debugcompiler.exe" --compile

REM Check compiled output exists
if not exist "compiled.gsic" (
    echo ERROR: compiled.gsic not found!
    exit /b 1
)

REM gsic file
set DEST="C:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\T8SpawnPatch\SpawnPatch.gsic"

REM
copy /Y "compiled.gsic" %DEST%

REM hashes.txt generated
set DEST="C:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\T8SpawnPatch\hashes.txt"

REM
copy /Y "hashes.txt" %DEST%

REM Delete intermediate files
del /Q "compiledclient.omap" 2>nul
del /Q "compiled.omap" 2>nul
del /Q "compiled.cscc" 2>nul
del /Q "compiled.gsic" 2>nul
del /Q "hashes.txt" 2>nul

echo Done: SpawnPatch.gsic updated and temp files cleaned.
endlocal
