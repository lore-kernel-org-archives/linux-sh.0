From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 02 Apr 2013 04:18:32 +0000
Subject: Re: [PATCH 0/5 v3] ARM: shmobile: Add SMSC support on Bock-W
Message-Id: <87sj395zvv.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
 <87fvzb56n3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvzb56n3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Simon

These patches are v3 of extpin support on r8a7778,
and enable SMSC ether support on Bock-W board

This patch set is based latest simon/next

Kuninori Morimoto (5):
      ARM: shmobile: r8a7778: remove pointless PLATFORM_INFO()
      ARM: shmobile: r8a7778: add r8a7778_init_irq_extpin()
      ARM: shmobile: bockw: add SMSC ethernet support
      ARM: shmobile: bockw: enable network settings on bootargs
      ARM: shmobile: bockw: enable SMSC ethernet on defconfig

 arch/arm/boot/dts/r8a7778-bockw.dts           |    2 +-
 arch/arm/configs/bockw_defconfig              |   34 ++++++++++--
 arch/arm/mach-shmobile/Kconfig                |    1 +
 arch/arm/mach-shmobile/board-bockw.c          |   38 ++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |   70 +++++++++++++++++++------
 6 files changed, 125 insertions(+), 21 deletions(-)
