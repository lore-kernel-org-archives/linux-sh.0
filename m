From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 28 Mar 2013 08:47:39 +0000
Subject: [PATCH 0/4] ARM: shmobile: move global functions to each header
Message-Id: <87zjxnlxlj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Magnus

These patches move each CPUs global functions from common.h to each header.
Latest APE6/M1/H2 already did it.
I didn't test these patches on real board,
but, did compile test

Kuninori Morimoto (4):
      ARM: shmobile: sh7372: move global functions to sh7372.h
      ARM: shmobile: sh73a0: move global functions to sh73a0.h
      ARM: shmobile: r8a7740: move global functions to r8a7740.h
      ARM: shmobile: r8a7779: move global functions to r8a7779.h

 arch/arm/mach-shmobile/include/mach/common.h  |   54 -------------------------
 arch/arm/mach-shmobile/include/mach/r8a7740.h |    9 +++++
 arch/arm/mach-shmobile/include/mach/r8a7779.h |   13 ++++++
 arch/arm/mach-shmobile/include/mach/sh7372.h  |   12 ++++++
 arch/arm/mach-shmobile/include/mach/sh73a0.h  |   15 +++++++
 5 files changed, 49 insertions(+), 54 deletions(-)



Best regards
---
Kuninori Morimoto
