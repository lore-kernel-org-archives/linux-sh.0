From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 26 Jul 2013 07:29:02 +0000
Subject: Re: [PATCH 0/11] ARM: shmobile: cleanup r8a7778/r8a7779
Message-Id: <877ggddbk5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are v2 of cleanup patches
Main diff v1 <-> v2 are
 - based on renesas-devel-20130726
 - sh-eth is not cleanuped this time

I hope sh-eth will be cleanuped in the future
on r8a7778/r8a7779

This patch set doesn't include new feature
of USB function which was included in previous patch set.
I will send it when these patches are accepted

Kuninori Morimoto (6):
      ARM: shmobile: r8a7778: cleanup registration of mmcif
      ARM: shmobile: r8a7778: cleanup registration of usb phy
      ARM: shmobile: r8a7778: cleanup registration of sdhi
      ARM: shmobile: r8a7778: cleanup registration of i2c
      ARM: shmobile: r8a7778: cleanup registration of hspi
      ARM: shmobile: r8a7779: cleanup registration of usb phy

 arch/arm/mach-shmobile/board-bockw.c          |   40 ++++++++++++++--
 arch/arm/mach-shmobile/board-marzen.c         |   24 +++++++++-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    8 ----
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    2 -
 arch/arm/mach-shmobile/setup-r8a7778.c        |   63 ++++---------------------
 arch/arm/mach-shmobile/setup-r8a7779.c        |   17 -------
 6 files changed, 66 insertions(+), 88 deletions(-)
