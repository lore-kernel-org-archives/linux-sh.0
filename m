From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 01 Jun 2010 04:31:29 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: update MMC/SHDI tiny document
Message-Id: <w3ptypncr1b.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

MMC0/SDHI1 (CN7) can be selected by dip switch.
And card voltage can be selected by jumper pin.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 67da737..2963a11 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -128,15 +128,21 @@
  */
 
 /*
- * MMC (CN7)
+ * MMC0/SDHI1 (CN7)
  *
- * J22 : 1-2: 1.8v for MMC
- *       2-3: 3.3v for MMC
- * SW1 : OFF
- * SW33: bit1: OFF
- *       bit2: ON
- *       bit3: ON
- *       bit4: X
+ * J22 : select card voltage
+ *       1-2 pin : 1.8v
+ *       2-3 pin : 3.3v
+ *
+ *        SW1  |             SW33
+ *             | bit1 | bit2 | bit3 | bit4
+ * ------------+------+------+------+-------
+ * MMC0   OFF  |  OFF |  ON  |  ON  |  X
+ * SDHI1  OFF  |  ON  |   X  |  OFF | ON
+ *
+ * voltage lebel
+ * CN7 : 1.8v
+ * CN12: 3.3v
  */
 
 /* MTD */
-- 
1.7.0.4

