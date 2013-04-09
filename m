From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 09 Apr 2013 09:36:11 +0000
Subject: [RFC][PATCH 0/2] ARCH: shmobile: Bock-W shmobile_defconfig support
Message-Id: <87vc7w9hbs.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are shmobile_defconfig support on Bock-W.

I didn't care current bockw_defconfig on this series.
But, Bock-W will can't boot from bockw_defconfig, because of memory start address
So, I added [RFC] on this series.

If you want to unify Bock-W to shmobile_defconfig,
please remove bockw_defconfig.
Then, you can add my Acked-by if you want

I'm using

simon/topic/defconfig-consolidation+next-20130403 + renesas-next-20130405v2 tags

Kuninori Morimoto (2):
      ARM: shmobile: bockw: add dummy regulators for SMSC
      ARM: shmobile: bockw: enable boot from shmobile_defconfig

 arch/arm/boot/dts/r8a7778-bockw.dts  |    2 +-
 arch/arm/configs/shmobile_defconfig  |    3 ++-
 arch/arm/mach-shmobile/board-bockw.c |   11 +++++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)


Best regards
---
Kuninori Morimoto
