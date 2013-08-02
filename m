From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 02 Aug 2013 01:33:02 +0000
Subject: [PATCH 0/4] ARM: shmobile: add missing __initdata
Message-Id: <87wqo498s4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

This patch adds missing __initdata to driver data/resource
which are used from platform_device_register_xxx()

Kuninori Morimoto (4):
      ARM: shmobile: r8a7779: add missing __initdata
      ARM: shmobile: r8a7790: add missing __initdata
      ARM: shmobile: bockw: add missing __initdata
      ARM: shmobile: lager: add missing __initdata

 arch/arm/mach-shmobile/board-bockw.c   |    8 ++++----
 arch/arm/mach-shmobile/board-lager.c   |    4 ++--
 arch/arm/mach-shmobile/setup-r8a7779.c |    2 +-
 arch/arm/mach-shmobile/setup-r8a7790.c |    4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)


Best regards
---
Kuninori Morimoto
