From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 01 Nov 2013 00:59:17 +0000
Subject: [PATCH 0/2] ARM: shmobile: r8a7779: cleanup patches
Message-Id: <877gctym1q.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are cleanup patches for r8a7779

Kuninori Morimoto (2):
      ARM: shmobile: r8a7779: camera-rcar header cleanup
      ARM: shmobile: r8a7779: cleanup registration of sh_eth

 arch/arm/mach-shmobile/board-marzen.c         |    1 +
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    3 ---
 arch/arm/mach-shmobile/setup-r8a7779.c        |   20 --------------------
 3 files changed, 1 insertion(+), 23 deletions(-)


Best regards
---
Kuninori Morimoto
