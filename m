From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 04 Dec 2014 03:56:37 +0000
Subject: [PATCH 0/2] ARM: shmobile: defconfig: add MTD_BLOCK
Message-Id: <87a93483uk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These patches are for shmobile_defconfig.
1st patch cleanups current shmobile_defconfig which was not created from savedefconfig.
2nd patch adds MTD_BLOCK which is needed for SPI-FLASH

Kuninori Morimoto (2):
      ARM: shmobile: defconfig: cleanup by savedefconfig
      ARM: shmobile: defconfig: add MTD_BLOCK

 arch/arm/configs/shmobile_defconfig |   26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)



Best regards
---
Kuninori Morimoto
