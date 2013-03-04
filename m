From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 04 Mar 2013 07:10:22 +0000
Subject: [PATCH 0/3] ARM: shmobile: r8a7779: tidyup patches
Message-Id: <874ngrr679.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are tidyup patches for r8a7779

Kuninori Morimoto (3):
      ARM: shmobile: r8a7779: fixup dtsi typo
      ARM: shmobile: r8a7779: fixup DT machine name
      ARM: shmobile: r8a7779: use add gic_iid macro

 arch/arm/boot/dts/r8a7779.dtsi         |    2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c |   26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

Best regards
---
Kuninori Morimoto
