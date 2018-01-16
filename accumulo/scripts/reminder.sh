#!/bin/bash

border() {
    printf "\t%49s\n" | tr ' ' '*'
}

empty_line() {
    printf "\t*%47s*\n" ''
}

ascii_art() {
    echo " ______                                              ___             "
    echo "/\  _  \                                            /\_ \            "
    echo "\ \ \L\ \    ___    ___   __  __    ___ ___   __  __\//\ \     ___   "
    echo " \ \  __ \  /'___\ /'___\/\ \/\ \ /' __\` __\`\/\ \/\ \ \ \ \   / __\`\ "
    echo "  \ \ \/\ \/\ \__//\ \__/\ \ \_\ \/\ \/\ \/\ \ \ \_\ \ \_\ \_/\ \L\ \\"
    echo "   \ \_\ \_\ \____\ \____\\ \____/\ \_\ \_\ \_\ \____/ /\____\ \____/"
    echo "    \/_/\/_/\/____/\/____/ \/___/  \/_/\/_/\/_/\/___/  \/____/\/___/ "
    echo -e "\n                    Single container (Zookeeper + Hadoop + Accumulo)\n"
}

print_reminder() {
    ascii_art
    echo -e "\e[1m" # bold
    border
    printf "\t*  \$INSTANCE = %-32s *\n" $INSTANCE 
    printf "\t*  \$ACCUMULO_PASSWORD = %-23s *\n" $ACCUMULO_PASSWORD 
    printf "\t*  \$ACCUMULO_DEFAULT_TABLE = %-18s *\n" $ACCUMULO_DEFAULT_TABLE 
    if nc -z localhost 50070 ; then
        printf "\t*  %-44s *\n" "http://localhost:50070"
    else
        printf "\t*  %-44s *\n" "Hadoop overview not available"
    fi
    if nc -z localhost 9995 ; then
        printf "\t*  %-44s *\n" "http://localhost:9995"
    else
        printf "\t*  %-44s *\n" "Accumulo overview not available"
    fi
    empty_line
    printf "\t*  %-44s *\n" "To print this help, type 'reminder.sh'"
    printf "\t*  %-44s *\n" "To start accumulo, type 'entrypoint.sh'"
    if [ -z "$(ls -A $ACCUMULO_HOME/lib/ext)" ]; then
        printf "\t* \e[31;1m %-40s \e[0m*\n" "There is no jar loaded! "
    else
        printf "\t* \e[36;1m %-44s \e[0m*\n" "$(ls -A $ACCUMULO_HOME/lib/ext/*.jar | wc -l) jar(s) imported    "
        echo -ne "\e[1m"
    fi
    border
    echo -e "\e[21m"
}

print_reminder