REM Build the version number.
SET /p version_root=<src\dbcurtain\versionroot.txt
SET version_number=%version_root%.%BUILD_BUILDNUMBER%

REM Write the version number where Aperture can find it at runtime.
ECHO %version_number%>src\dbcurtain\version.txt

REM Build the Windows package.
SET scripts_dir=C:\Source\Miniconda3\Scripts
CALL %scripts_dir%\activate base
CALL %scripts_dir%\conda config --set ssl_verify false
setlocal enabledelayedexpansion
FOR /l %%n IN (6, 1, 10) DO (
    CALL %scripts_dir%\conda-build --py 3.%%n recipe
)
CALL %scripts_dir%\conda config --set ssl_verify true

REM Copy the version file & release batch file to staging.
COPY src\dbcurtain\version.txt %Build_ArtifactStagingDirectory%
IF %ERRORLEVEL% NEQ 0 EXIT /b %ERRORLEVEL%
COPY batch\release.bat %Build_ArtifactStagingDirectory%
IF %ERRORLEVEL% NEQ 0 EXIT /b %ERRORLEVEL%

REM Copy the conda package to staging.
MKDIR %Build_ArtifactStagingDirectory%\win-64
SET build_dir=C:\Source\Miniconda3\conda-bld
FOR /l %%n IN (6, 1, 10) DO (
    SET file_name=dbcurtain-%version_number%-py3%%n_0.tar.bz2
    COPY %build_dir%\win-64\!file_name! %Build_ArtifactStagingDirectory%\win-64
)
IF %ERRORLEVEL% NEQ 0 EXIT /b %ERRORLEVEL%
