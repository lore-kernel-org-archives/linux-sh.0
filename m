From: morimoto.kuninori@renesas.com
Date: Mon, 08 Dec 2008 07:17:17 +0000
Subject: [Bug report] dead lock is occur in mutex_trylock
Message-Id: <uej0jyw3m.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

I noticed dead lock occur on latest linux-sh.git

It works well if I use old ${LINUX}/arch/sh/include/asm/mutex-llsc.h,
But, latest mutex-llsc.h seems cause dead lock on __mutex_fastpath_trylock.

It confirmed on AP325 board.

Best regards
--
Kuninori Morimoto
 
