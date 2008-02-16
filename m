From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sat, 16 Feb 2008 18:38:00 +0000
Subject: Current git very broken on the Dreamcast
Message-Id: <1203187080.6737.3.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Will seek to bisect this, but I have just updated my sources to the
latest git and it is not booting at all on the Dreamcast.

With early printk on, I get nothing more than this before an instant
reboot:

[    0.000000] Linux version 2.6.25-rc2-10953-g52065cd
(adrian@bossclass) (gcc version 3.4.6) #511 PREEMPT Sat Feb 16 18:31:43
GMT 2008
[    0.000000] console [sercon0] enabled
[    0.000000] Booting machvec: Sega Dreamcast


