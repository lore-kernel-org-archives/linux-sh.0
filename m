From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 30 Aug 2012 01:57:21 +0000
Subject: [PATCH 0/2] ARM: shmobile: marzen: fixup regulator setting
Message-Id: <87y5kxxhtt.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are bug fix patches for marzen board.

Kuninori Morimoto (2):
      ARM: shmobile: marzen: fixup smsc911x id for regulator
      ARM: shmobile: marzen: fixup regulator id for smsc911x

 arch/arm/mach-shmobile/board-marzen.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

marzen board will got WARNING and can't boot without these patches
if it has CONFIG_REGULATOR on .config

Best regards
---
Kuninori Morimoto
