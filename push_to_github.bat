@echo off
echo =========================================
echo     PUSH FINDKART TO GITHUB
echo =========================================
echo.

echo This script will help you push your FindKart project to GitHub.
echo Repository: https://github.com/Sabyasachi2125/FindKart.git
echo.

:: Check if git is available
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Git is not installed or not in PATH
    echo Please install Git for Windows from: https://git-scm.com/download/win
    pause
    exit /b 1
)

echo ✓ Git is available
echo.

:: Check if we're already in a git repository
if exist ".git" (
    echo ✓ Git repository already initialized
    goto :add_remote
) else (
    echo Initializing Git repository...
    git init
    if %errorlevel% neq 0 (
        echo ERROR: Failed to initialize Git repository
        pause
        exit /b 1
    )
    echo ✓ Git repository initialized
)

:add_remote
echo.
echo Adding GitHub remote repository...
git remote remove origin >nul 2>&1
git remote add origin https://github.com/Sabyasachi2125/FindKart.git
if %errorlevel% neq 0 (
    echo ERROR: Failed to add remote repository
    pause
    exit /b 1
)
echo ✓ Remote repository added

echo.
echo Checking repository status...
git status

echo.
echo Adding all files to staging area...
git add .
if %errorlevel% neq 0 (
    echo ERROR: Failed to add files
    pause
    exit /b 1
)
echo ✓ Files added to staging area

echo.
echo Creating initial commit...
git commit -m "Initial commit: Complete FindKart e-commerce application

Features:
- Modern FindKart brand theme with logo
- Product catalog with image support
- Shopping cart functionality
- Order management system
- User authentication
- Responsive design for all devices
- Complete database schema and setup scripts

Technologies: Java, JSP/Servlets, MySQL, Maven, Tomcat"

if %errorlevel% neq 0 (
    echo ERROR: Failed to create commit
    echo This might be because there are no changes to commit
    echo.
)

echo.
echo =========================================
echo     READY TO PUSH TO GITHUB
echo =========================================
echo.
echo Your repository is ready to be pushed to:
echo https://github.com/Sabyasachi2125/FindKart.git
echo.
echo IMPORTANT: You may need to authenticate with GitHub
echo.
set /p push_confirm="Do you want to push to GitHub now? (y/n): "

if /i "%push_confirm%"=="y" (
    echo.
    echo Pushing to GitHub...
    echo.
    git branch -M main
    git push -u origin main
    
    if %errorlevel% equ 0 (
        echo.
        echo =========================================
        echo     SUCCESS!
        echo =========================================
        echo.
        echo ✓ FindKart has been successfully pushed to GitHub!
        echo.
        echo Repository URL: https://github.com/Sabyasachi2125/FindKart
        echo.
        echo You can now:
        echo 1. View your repository online
        echo 2. Share the repository with others
        echo 3. Clone it on other machines
        echo 4. Collaborate with team members
        echo.
        echo To clone this repository elsewhere:
        echo git clone https://github.com/Sabyasachi2125/FindKart.git
        echo.
    ) else (
        echo.
        echo =========================================
        echo     PUSH FAILED
        echo =========================================
        echo.
        echo The push to GitHub failed. This could be due to:
        echo.
        echo 1. Authentication issues - You may need to set up:
        echo    - Personal Access Token
        echo    - SSH Keys
        echo    - GitHub CLI authentication
        echo.
        echo 2. Repository permissions
        echo 3. Network issues
        echo.
        echo Please check GitHub documentation for authentication:
        echo https://docs.github.com/en/authentication
        echo.
        echo You can try pushing manually later with:
        echo git push -u origin main
        echo.
    )
) else (
    echo.
    echo Repository prepared but not pushed.
    echo.
    echo To push manually later, run:
    echo git push -u origin main
    echo.
    echo Or run this script again.
)

echo.
echo =========================================
echo     ADDITIONAL NOTES
echo =========================================
echo.
echo Repository structure pushed:
echo ✓ Source code (Java, JSP, CSS)
echo ✓ Database schema and setup scripts
echo ✓ Maven configuration
echo ✓ Documentation and README
echo ✓ Setup and utility scripts
echo.
echo Note: Large files and images may be excluded by .gitignore
echo You can add specific images later if needed.
echo.

pause