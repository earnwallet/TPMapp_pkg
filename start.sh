clear
echo "=============";
echo "=====PKG=====";
echo "===PacKaGe===";
echo "===Manager===";
echo "=====TOOL====";
echo "=============";
sleep 1;
clear
echo "What would you like to do?";
echo " (1) Install";
echo " (2) Update";
echo " (3) Remove";
echo " (x) Exit";
read cho
if [ "$cho" == "1" ];
then
    #Install
    clear
    type="unknown";
    echo "What would you like to install";
    echo " (1) Module";
    echo " (2) Application";
    echo " (x) Exit";
    read choi
    if [ "$choi" == "1" -o "$choi" == "2" -o "$choi" == "x" ];
    then
        echo "OK!";
    else
        echo "Wrong choice.";
        exit 1;
    fi
    if [ "$choi" == "1" ];
    then
        type="mod";
        echo "Installing Module";
    fi
    if [ "$choi" == "2" ];
    then
        type="app";
        echo "Installing Application";
    fi
    if [ "$choi" == "x" ];
    then
        echo "Bye";
        exit 0;
    fi
    clear
    echo "Select source";
    echo " (1) World (GitHub)";
    # TODO: add custom repos, not from github.
    echo " (x) Exit";
    read choic
    if [ "$choic" == "1" -o "$choic" == "x" ];
    then
        echo "OK!";
    else
        echo "Wrong choice.";
        exit 1;
    fi
    if [ "$choic" == 1 ];
    then
        clear
        echo "Creator:";
        read creator
        echo "Package name:";
        read pkg
        clear
        echo "=INSTALLING=";
        bash /home/`whoami`/TPM/core/install.sh "$type" "$creator" "$pkg"
        ec=$?;
        if [ $ec == "0" ];
        then
            echo "Installed";
            exit;
        else
            echo "Installation failed, most likely there's more info above.";
            echo " [ExitCode] $ec";
            sleep 3;
            exit $ec;
        fi
    fi
    if [ "$choic" == "x" ];
    then
        echo "Bye";
        exit 0;
    fi
fi

if [ "$cho" == "2" ];
then
    #Update
    clear
    type="unknown";
    echo "What would you like to update";
    echo " (1) Module";
    echo " (2) Application";
    #echo " (3) Core";
    echo " (x) Exit";
    read choi
    if [ "$choi" == "1" -o "$choi" == "2" -o "$choi" == "x" ];
    then
        echo "OK!";
    else
        echo "Wrong choice";
        exit 1;
    fi
    if [ "$choi" == "1" ];
    then
        type="mod";
        echo "Updating Module";
    fi
    if [ "$choi" == "2" ];
    then
        type="app";
        echo "Updating Application";
    fi
    if [ "$choi" == "x" ];
    then
        echo "Bye";
        exit 0;
    fi
    clear
    cd /home/`whoami`/TPM/"$type"s/
    echo "=============";
    for f in *;
    do
         echo " (+) $f";
         sleep 0.2;
    done
    echo "=============";
    echo "Which $type would you like to update?";
    read choic
    clear
    echo "Updating $choic $type";
    echo "Step 1/2 - Looking for update.sh file.";
    cd /home/`whoami`/TPM/"$type"s/"$choic"/
    for f in *;
    do
         if [ "$f" == "update.sh" ];
         then
             echo "Found $f, executing";
             bash $f;
         fi
         # echo " (=) $f";
    done
    echo "Step 2/2 - Looking for .git";
    for f in .*;
    do
         if [ "$f" == ".git" ];
         then
             echo "Found $f, pulling";
             git pull;
         fi
         # echo " (=) $f";
    done
    echo "Updated!";
fi

if [ "$cho" == "3" ];
then
    clear
    type="unknown";
    echo "What would you like to update";
    echo " (1) Module";
    echo " (2) Application";
    echo " (x) Exit";
    read choi
    if [ "$choi" == "1" -o "$choi" == "2" -o "$choi" == "x" ];
    then
        echo "OK!";
    else
        echo "Wrong choice";
        exit 1;
    fi
    if [ "$choi" == "1" ];
    then
        type="mod";
        echo "Removimg Module";
    fi
    if [ "$choi" == "2" ];
    then
        type="app";
        echo "Removing Application";
    fi
    if [ "$choi" == "x" ];
    then
        echo "Bye";
        exit 0;
    fi
    cd /home/`whoami`/TPM/"$type"s/
    echo "=============";
    for f in *;
    do
         echo " (+) $f";
         sleep 0.2;
    done
    echo "=============";
    echo "Which $type would you like to remove?";
    read name
    clear
    echo "Removing...";
    sleep 3
    rm -rf "/home/`whoami`/TPM/"$type"s/$name";
    echo "Complete!";
    sleep 3;
    exit;
fi

if [ "$choi" == "x" ];
then
    echo "Bye";
    exit 0;
fi
exit 0;
