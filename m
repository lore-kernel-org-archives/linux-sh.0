From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 24 Nov 2010 13:50:47 +0000
Subject: [GIT PULL] rmobile updates for 2.6.37-rc4
Message-Id: <20101124135047.GA3270@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101108011327.GA10728@linux-sh.org>
In-Reply-To: <20101108011327.GA10728@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This was going to be a fairly simple set of changes, but it was
unfortunately discovered that the FSIDIV clock has been doing some fairly
bogus things with regards to finding creative ways to sidestep its
refcount, leading to situations where users of the clock in question can
find themselves invariably shafted by the alsa driver. As a result of
this, a bit of a rethink was needed, resulting in the FSIDIV and PLLC2
clock handling being refactored for AP4.

As we're already at -rc3 this is obviously a lot bigger than I would care
for at this point. The alternative would be a series of reverts that
would result in a similar amount of churn, and then giving it all a go
again for .38. I can prepare a topic branch that does that if you'd
prefer that option, this would however render the alsa driver unusable
for .37.

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git rmobile-fixes-for-linus

Which contains:

Kuninori Morimoto (6):
      ARM: mach-shmobile: clock-sh7372: remove fsidiv bogus disable
      ARM: mach-shmobile: ap4evb: FSI clock use proper process for HDMI
      ARM: mach-shmobile: ap4evb: FSI clock use proper process for ak4642
      ARM: mach-shmobile: clock-sh7372: modify error code
      ARM: mach-shmobile: clock-sh7372: remove unnecessary fsi clocks
      ARM: mach-shmobile: clock-sh7372: remove bogus pllc2 clock toggling.

Magnus Damm (1):
      ARM: mach-shmobile: sh7372 USB0/IIC1 MSTP fix

 arch/arm/mach-shmobile/board-ap4evb.c |  147 +++++++++++++++++++++++++--------
 arch/arm/mach-shmobile/clock-sh7372.c |   33 ++------
 include/sound/sh_fsi.h                |    6 +-
 sound/soc/sh/fsi.c                    |   25 ++++--
 4 files changed, 140 insertions(+), 71 deletions(-)
