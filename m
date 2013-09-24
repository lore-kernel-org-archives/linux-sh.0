From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 24 Sep 2013 06:03:31 +0000
Subject: ARM: shmobile: r8a7778: cleanup patches
Message-Id: <874n9asqmo.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are cleanup patches for r8a7778,
based on renesas-devel-20130922 tag

Kuninori Morimoto (3):
      ARM: shmobile: r8a7778: cleanup registration of vin
      ARM: shmobile: r8a7778: cleanup registration of sh_eth
      ARM: shmobile: r8a7778: r8a7778_register_hspi() become static

 arch/arm/mach-shmobile/board-bockw.c          |   46 +++++++++++++++++++----
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    3 --
 arch/arm/mach-shmobile/setup-r8a7778.c        |   50 +------------------------
 3 files changed, 40 insertions(+), 59 deletions(-)


Best regards
---
Kuninori Morimoto
