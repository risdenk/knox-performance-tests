#!/usr/bin/env sh

/usr/sbin/kdc --ports=88 --detach
/usr/sbin/kadmind --ports=749

