From: kuninori.morimoto.gx@renesas.com
Date: Fri, 06 Apr 2012 08:26:54 +0000
Subject: Re: [PATCH 0/7 v2] ARM: mach-shmobile: add Armadillo800eva board support
Message-Id: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael, Magnus
Cc Simon, nakai-san, Saneyoshi-san

These are v2 of basic R8A7740 A1 Armadillo800eva baord support patch set.
These are based on linus/master branch.

Kuninori Morimoto (7):
      ARM: mach-shmobile: pfc-r8a7740: add gpio_irq support
      ARM: mach-shmobile: add armadillo800eva board support.
      ARM: mach-shmobile: armadillo800eva: add defconfig
      ARM: mach-shmobile: armadillo800eva: add support LCDC0
      ARM: mach-shmobile: armadillo800eva: add support ST1232
      ARM: mach-shmobile: armadillo800eva: add support gpio_key
      ARM: mach-shmobile: armadillo800eva: add support sh_eth

v1 -> v2

- based on linus/master
- I added .gpio_irq support patch to this patch series (#1)
- use <mach/irqs.h> (#2)
- based on latest linus/master LCDC (#4)
- tidyup typo (#2, #6)
