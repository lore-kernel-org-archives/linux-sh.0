From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 24 Aug 2009 08:19:47 +0000
Subject: Current ms7724se LAN doesn't work
Message-Id: <uzl9pr5cs.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear all

I got latest kernel from Paul's git,
and current ms7724se LAN doesn't work.

When If I remove 
archdata = {
         .hwblk_id = HWBLK_ETHER,
}
from ${LINUX}/arch/sh/boards/mach-se/7724/setup.c
then, it start works for me.

Are there any CONFIG to use SH-ETH or HWBLK ?

Best regards
--
Kuninori Morimoto
 
