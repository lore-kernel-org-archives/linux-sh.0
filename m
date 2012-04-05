From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Apr 2012 08:32:20 +0000
Subject: [PATCH 0/6] ARM: mach-shmobile: add Armadillo800eva board support
Message-Id: <87pqbm4m0b.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael, Magnus
Cc Simon, nakai-san, Saneyoshi-san

These are basic R8A7740 A1 Armadillo800eva baord support patch set.
These are based on rafael/master branch.

Kuninori Morimoto (6):
      ARM: mach-shmobile: add armadillo800eva board support.
      ARM: mach-shmobile: armadillo800eva: add defconfig
      ARM: mach-shmobile: armadillo800eva: add support LCDC0
      ARM: mach-shmobile: armadillo800eva: add support ST1232
      ARM: mach-shmobile: armadillo800eva: add support gpio_key
      ARM: mach-shmobile: armadillo800eva: add support sh_eth

These still not support device tree at this point,
but I will work for it soon.

#5 patch require R8A7740 .gipo_irq support patch which I posted this morning.
[PATCH] ARM: mach-shmobile: pfc-r8a7740: add .gpio_irq support

#6 patch adds sh_eth support to armadillo800eva board,
no compile error, but doesn't work on rafael/master at this point.
it needs shimoda-san's sh_eth patches.

git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git
10b9194f959608368ed89df1937f17cfe6bd6d84
(net: sh_eth: fix endian check for architecture independent)

git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
73a0d907301ece200d32b4e8ba2da2ca296b507f
(net: sh_eth: add support R8A7740)

I hope these patches are back-ported and go to LTSI support.

Best regards
---
Kuninori Morimoto
