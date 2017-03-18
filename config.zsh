# active xdebug in cli
export XDEBUG_CONFIG="idekey=PHPSTORM"

# delete whole line with ctrl+u
bindkey \^U backward-kill-line
# no confirmation message when using rm -rf
setopt rm_star_silent

# Common alias 
alias xdebug_stop="mv /usr/local/etc/php/5.6/conf.d/ext-xdebug.ini /usr/local/etc/php/5.6/conf.d/ext-xdebug.ini.deactivated"
alias xdebug_start="mv /usr/local/etc/php/5.6/conf.d/ext-xdebug.ini.deactivated /usr/local/etc/php/5.6/conf.d/ext-xdebug.ini"

alias slow_query_start="echo \"SET GLOBAL slow_query_log = 'ON';\" | mysql -u root -p"
alias slow_query_stop="echo \"SET GLOBAL slow_query_log = 'OFF';\" | mysql -u root -p"

# Akeneo alias
alias b="bin/behat"
alias s="bin/phpspec run"
alias ac="app/console"
alias cc="rm -rf app/cache/*"
alias sel="nohup java -jar /Users/ahocquard/Workspace/akeneo/selenium/selenium-server-standalone-2.53.1.jar >/dev/null 2>&1 &"
alias mongo_start="nohup mongod >/dev/null 2>&1 &"

phpunitWithFilter() {
    if [[ "$#" == 2 ]]; then
        export PHPUNIT_TEST_NAME="$2"
    else
        [[ "$#" == 3 ]]
        export PHPUNIT_TEST_NAME="$2"
        export PHPUNIT_INTEGRATION_FILE="$3"
    fi

    [[ "$1" == "true" ]] && xdebug_start 2>/dev/null || xdebug_stop 2>/dev/null
    bin/phpunit -c app/ --filter "$PHPUNIT_TEST_NAME" "$PHPUNIT_INTEGRATION_FILE"
}
alias pf="phpunitWithFilter false"
alias xpf="phpunitWithFilter true"


phpunit() {
    if [[ "$#" == 2 ]]; then
        export PHPUNIT_INTEGRATION_FILE="$2"
    fi

    [[ "$1" == "true" ]] && xdebug_start 2>/dev/null || xdebug_stop 2>/dev/null
    bin/phpunit --debug -c app/  "$PHPUNIT_INTEGRATION_FILE"
}
alias p="phpunit false"
alias xp="phpunit true"
