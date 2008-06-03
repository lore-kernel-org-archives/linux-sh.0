From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Tue, 03 Jun 2008 22:41:12 +0000
Subject: resume woes on jornada (2.6.25)
Message-Id: <20080604004112.7cd033d6.Kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Greetings,

Been bugtracking this for ages. This is what I get :
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s)

When trying to resume it gives out a cold exception and shows the HP screen. Ive removed almost all components of the
kernel. Only stuff left is hd64461 chip (which really should be in suspend mode) and APM code.

I've gone through the arch/sh/boards/hp6xx/pm.c & pm_wakeup code and both seem fine. Nothing changed and everything is resonable.

What Im uncertain of is the arch/sh/kernel/pm.c code. It hasn't changed any since v2.6.17 (which had working suspend)
but it feels like the most resonable solution. It does some fly stuff trying to add itself as handle for the power button (0x600?).

Anyhow, suggestions are really appreciated as its bugging the hell out of me. Ive used same compiler on both 2.6.17 & 2.6.25 so this shouldn't caused by bad gcc.

Best wishes
Kristoffer
