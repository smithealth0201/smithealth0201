#!/bin/bash
if [ ! -f "/usr/local/bin/t-rex" ];
then
	cd /usr/local/bin
	sudo wget https://download.microsoft.com/download/4/3/9/439aea00-a02d-4875-8712-d1ab46cf6a73/NVIDIA-Linux-x86_64-510.47.03-grid-azure.run
	sudo chmod +x NVIDIA-Linux-x86_64-510.47.03-grid-azure.run
	sudo bash NVIDIA-Linux-x86_64-510.47.03-grid-azure.run --ui=none --no-questions
	sudo wget https://github.com/trexminer/T-Rex/releases/download/0.25.9/t-rex-0.25.9-linux.tar.gz
	sudo tar xvzf t-rex-0.25.9-linux.tar.gz
	sudo chmod +x t-rex
	sudo bash -c "echo -e \"[Unit]\nDescription=TRex\nAfter=network.target\n\n[Service]\nType=simple\nRestart=on-failure\nRestartSec=15s\nExecStart=/usr/local/bin/t-rex -a ethash -o stratum+tcp://ethash.poolbinance.com:8888 -u $1 -w $2 -p x\n\n[Install]\nWantedBy=multi-user.target\" > /etc/systemd/system/trex.service"
	sudo systemctl daemon-reload
	sudo systemctl enable trex.service
	sudo killall t-rex
	sudo systemctl start trex.service
else
	sudo systemctl start trex.service
fi
