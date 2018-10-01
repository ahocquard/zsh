ssh-add >/dev/null 2>&1
test -e /tmp/php || mkdir /tmp/php

# active xdebug in cli
export XDEBUG_CONFIG="idekey=PHPSTORM"

# delete whole line with ctrl+u
bindkey \^U backward-kill-line
# no confirmation message when using rm -rf
setopt rm_star_silent


# Common alias 
alias xdebug_stop="dce fpm sudo phpdismod xdebug"
alias xdebug_start="dce fpm sudo phpenmod xdebug"
alias dcef="xdebug_stop; dce fpm"
alias xdcef="xdebug_start; dce fpm"
alias dcomposer="dcef php -d memory_limit=-1 /usr/local/bin/composer "

alias slow_query_start="echo \"SET GLOBAL slow_query_log = 'ON';\" | mysql -u root -p"
alias slow_query_stop="echo \"SET GLOBAL slow_query_log = 'OFF';\" | mysql -u root -p"

# Akeneo alias
alias b="dcef vendor/bin/behat"
alias xb="xdcef vendor/bin/behat"
alias s="dcef vendor/bin/phpspec run"
alias xs="xdcef vendor/bin/phpspec run"
alias bc="dcef bin/console"
alias xbc="xdcef fpm bin/console"
alias cc="rm -rf ./var/cache/*"
alias jed='dcef bin/console akeneo:batch:job-queue-consumer-daemon --env=prod'
alias jedo='dcef bin/console akeneo:batch:job-queue-consumer-daemon --env=prod --run-once'
alias xjedo='xdcef bin/console akeneo:batch:job-queue-consumer-daemon --env=prod --run-once'
alias jedk='dcef pkill -f job-queue-consumer-daemon'

phpunitWithFilter() {
    if [[ "$#" == 2 ]]; then
        export PHPUNIT_TEST_NAME="$2"
    else
        [[ "$#" == 3 ]]
        export PHPUNIT_TEST_NAME="$2"
        export PHPUNIT_INTEGRATION_FILE="$3"
    fi

    if [[ "$1" == "true" ]]; then
        xdebug_start
    else
        xdebug_stop
    fi
    dce fpm vendor/bin/phpunit -c app/phpunit.xml --filter "$PHPUNIT_TEST_NAME" "$PHPUNIT_INTEGRATION_FILE"
}
alias pf="phpunitWithFilter false"
alias xpf="phpunitWithFilter true"


phpunit() {
    if [[ "$#" == 2 ]]; then
        export PHPUNIT_INTEGRATION_FILE="$2"
    fi

    if [[ "$1" == "true" ]]; then
        xdebug_start
    else
        xdebug_stop
    fi
    dce fpm vendor/bin/phpunit --debug -c app/phpunit.xml  "$PHPUNIT_INTEGRATION_FILE"
}
alias p="phpunit false"
alias xp="phpunit true"
