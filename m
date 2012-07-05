From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Jul 2012 01:08:00 +0000
Subject: Re: [PATCH 2/7] ARM: shmobile: r8a7740: add basic pm domain support
Message-Id: <87d34bqaky.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mx3gtc2d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx3gtc2d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul, Magnus, and Rafael


> > In this case it's not really soc-specific though, so code here needs
> > to be reworked for sharing between sh7372 and r8a7740 (and sh73a0 too
> > perhaps).
> 
> I see.
> I fix this naming on v2 patch set.

Sorry, not naming, sharing.

>>> Rafael

Kuninori Morimoto (7):
      1 ARM: shmobile: r8a7740: fixup: MSEL1CR 7bit control
      2 ARM: shmobile: r8a7740: add basic pm domain support
      3 ARM: shmobile: r8a7740: add A3SP pm domain support
      4 ARM: shmobile: r8a7740: add A4LC pm domain support
      5 ARM: shmobile: armadillo800eva: USB Func enables external IRQ mode
      6 ARM: shmobile: armadillo800eva: A4LC domain includes LCDC
      7 ARM: shmobile: armadillo800eva: A3SP domain includes USB

Then, #2/#3/#4/#6/#7 will be updated.
but #1/#5 have no update.
Should I re-send these too on v2?
Or can you consider these 2 independently ?

Best regards
---
Kuninori Morimoto
