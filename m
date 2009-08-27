From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 27 Aug 2009 01:36:58 +0000
Subject: current kernel say "Unaligned kernel access on behalf"
Message-Id: <uocq2ghqd.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi all

I tried current Paul's git
and it say a lot of error/warning after network working.
following is log

----- log -----------------------
(snip)
RPC: Registered tcp transport module.
/opt/usr/src/WORK/morimoto/gitlinux/sh-2.6/drivers/rtc/hctosys.c: unable to ope)
net eth0: attached phy 31 to driver SMSC LAN8700
Sending DHCP requests .
PHY: 0:1f - Link is Up - 100/Full
.
Unaligned kernel access on behalf of "swapper" pid=0 pc=0x882dcfc8 ins=0x882c
Fixing up unaligned kernel access in "swapper" pid=0 pc=0x882dcfc8 ins=0x6362
Unaligned kernel access on behalf of "swapper" pid=0 pc=0x882dd012 ins=0x882a
Fixing up unaligned kernel access in "swapper" pid=0 pc=0x882dd012 ins=0x6176
Unaligned kernel access on behalf of "swapper" pid=0 pc=0x882dd014 ins=0x882a
...
----------------------------------

If I use after 7436cde6b2ca71049051620c68c26522bb3403bf
all say above

If I use 9a4af027a03e10e97f56081cd7dd1fda5282bd9c
It say
-------------------------------------------------
Fixing up unaligned kernel access in "swapper" pid=0 pc=0x882dcf54 ins=0x6362   
Fixing up unaligned kernel access in "swapper" pid=0 pc=0x882dcf9e ins=0x6176   
Fixing up unaligned kernel access in "swapper" pid=0 pc=0x882dcfa0 ins=0x6276   
-------------------------------------------------

If I use c3144fc46f987413df10e83659f0bf1aad76f79e
It works well for me

what's happen ??
