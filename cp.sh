#!/bin/bash
while :
do
	/usr/bin/find /root/aa/* -type f -cmin +0.1 -exec cp {} /root/bb/  \; && /usr/bin/find /root/aa/* -type d -cmin +0.1 -exec cp -r {} /root/bb/ \;
				sleep 10
			done

