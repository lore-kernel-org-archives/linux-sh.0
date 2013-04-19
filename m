From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 19 Apr 2013 03:06:04 +0000
Subject: [PATCH 0/3 v2] ARM: shmobile: r8a7778/bockw: add SDHI0 support
Message-Id: <874nf36wyu.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Laurent

These are v3 patches of SDHI support on Bock-W board.

#1 patch adds common macro for each device definitions.
Laurent, can you accept it ?
it is useful for new feature IMO

These are based on renesas-next-20130418 tags

Kuninori Morimoto (3):
      sh-pfc: r8a7778: add common PFC macro helper
      sh-pfc: r8a7778: add SDHI support
      ARM: shmobile: bockw: add SDHI0 support

 arch/arm/mach-shmobile/board-bockw.c |   35 +++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c |  167 ++++++++++++++++++++++++++++++++--
 2 files changed, 194 insertions(+), 8 deletions(-)


Best regards
---
Kuninori Morimoto
