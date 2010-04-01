From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Thu, 01 Apr 2010 17:24:11 +0000
Subject: How usleep works?
Message-Id: <201004011924.11879.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all,
I have this piece of software:
	rs485TxEnVal = 1;
	// set high a port of the sh2a 7203
	rs485TxEnExit = write(rs485TxEn_fd,&rs485TxEnVal,sizeof(rs485TxEnVal)); 
	if ((rs485TxEnExit != 1) || (rs485TxEnExit = -1)) {return 0;}

	usleep(200);

	rs485TxEnVal = 0;
	// set low a port of the sh2a 7203
	rs485TxEnExit = write(rs485TxEn_fd,&rs485TxEnVal,sizeof(rs485TxEnVal));
	if ((rs485TxEnExit != 1) || (rs485TxEnExit = -1)) {return 0;}

The pulse I read with the scope is not about 200 uS, but about 10000 uS.

Does any of you know whay? 
I suspect bucause the function suppose a time elapses every uS, even if it 
really elapses every abotu 50 uS

Is it possible?

Thanks

-- 
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
