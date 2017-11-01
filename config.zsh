ssh-add >/dev/null 2>&1
ls /tmp/php >/deV/null 2>&1 || mkdir /tmp/php

# active xdebug in cli
export XDEBUG_CONFIG="idekey=PHPSTORM"

# delete whole line with ctrl+u
bindkey \^U backward-kill-line
# no confirmation message when using rm -rf
setopt rm_star_silent


# Common alias 
alias xdebug_stop="mv /usr/local/etc/php/7.1/conf.d/ext-xdebug.ini /usr/local/etc/php/7.1/conf.d/ext-xdebug.ini.deactivated"
alias xdebug_start="mv /usr/local/etc/php/7.1/conf.d/ext-xdebug.ini.deactivated /usr/local/etc/php/7.1/conf.d/ext-xdebug.ini"

alias slow_query_start="echo \"SET GLOBAL slow_query_log = 'ON';\" | mysql -u root -p"
alias slow_query_stop="echo \"SET GLOBAL slow_query_log = 'OFF';\" | mysql -u root -p"

# Akeneo alias
alias b="xdebug_stop 2>/dev/null; bin/behat"
alias xb="xdebug_start 2>/dev/null; bin/behat"
alias s="xdebug_stop 2>/dev/null; bin/phpspec run"
alias xs="xdebug_start 2>/dev/null; bin/phpspec run"
alias ac="app/console"
alias bc="bin/console"
alias cc="rm -rf ./var/cache/*"
alias sel="nohup java -jar /Users/ahocquard/Workspace/akeneo/selenium/selenium-server-standalone-2.53.1.jar >/dev/null 2>&1 &"
alias mongo_start="nohup mongod >/dev/null 2>&1 &"
alias ca="rm -Rf ./var/cache/* ./web/bundles/* ./web/css/* ./web/js/*; bc pim:install:ass -e=dev;bc assets:install --symlink web; yarn install; yarn run webpack"
alias jed='bin/console akeneo:batch:job-queue-consumer-daemon --env=prod'
alias jedo='bin/console akeneo:batch:job-queue-consumer-daemon --env=prod --run-once'
alias jedk='pkill -f job-queue-consumer-daemon'

phpunitWithFilter() {
    if [[ "$#" == 2 ]]; then
        export PHPUNIT_TEST_NAME="$2"
    else
        [[ "$#" == 3 ]]
        export PHPUNIT_TEST_NAME="$2"
        export PHPUNIT_INTEGRATION_FILE="$3"
    fi

    if [[ "$1" == "true" ]]; then
        xdebug_start 2>/dev/null
    else
        xdebug_stop 2>/dev/null
    fi
    bin/phpunit -c app/phpunit.xml --filter "$PHPUNIT_TEST_NAME" "$PHPUNIT_INTEGRATION_FILE"
}
alias pf="phpunitWithFilter false"
alias xpf="phpunitWithFilter true"


phpunit() {
    if [[ "$#" == 2 ]]; then
        export PHPUNIT_INTEGRATION_FILE="$2"
    fi

    if [[ "$1" == "true" ]]; then
        xdebug_start 2>/dev/null
    else
        xdebug_stop 2>/dev/null
    fi
    bin/phpunit --debug -c app/phpunit.xml  "$PHPUNIT_INTEGRATION_FILE"
}
alias p="phpunit false"
alias xp="phpunit true"
