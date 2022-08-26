REM Get the version number.
SET /p version_number=<artifact\dbcurtain\version.txt

REM Copy the packages to the conda server. The input to the batch file (d, t, or p)
REM determines which conda server we use.
SET output_dir=\\%1hqwweb02\conda
COPY artifact\dbcurtain\win-64\*.tar.bz2 %output_dir%\win-64
IF %ERRORLEVEL% NEQ 0 EXIT /b %ERRORLEVEL%

SET scripts_dir=C:\Source\Miniconda3\Scripts
CALL %scripts_dir%\activate base
CALL conda index %output_dir%
