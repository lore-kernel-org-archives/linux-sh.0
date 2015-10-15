From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 15 Oct 2015 06:59:37 +0000
Subject: [PATCH/RFC 6/6] arm: shmobile: rcar-gen2: Remove unused rcar_gen2_read_mode_pins()
Message-Id: <1444892377-10170-7-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The new boot mode reg infrastructure is now used in
place of rcar_gen2_read_mode_pins so the latter may now be removed.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/rcar-gen2.h       |  1 -
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 18 ------------------
 2 files changed, 19 deletions(-)

diff --git a/arch/arm/mach-shmobile/rcar-gen2.h b/arch/arm/mach-shmobile/rcar-gen2.h
index 8a66b4aae035..4c4ec37edc03 100644
--- a/arch/arm/mach-shmobile/rcar-gen2.h
+++ b/arch/arm/mach-shmobile/rcar-gen2.h
@@ -3,7 +3,6 @@
 
 void rcar_gen2_timer_init(void);
 #define MD(nr) BIT(nr)
-u32 rcar_gen2_read_mode_pins(void);
 void rcar_gen2_reserve(void);
 void rcar_gen2_pm_init(void);
 
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 81a446bf1702..403ee0ede379 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -29,24 +29,6 @@
 #include "common.h"
 #include "rcar-gen2.h"
 
-#define MODEMR 0xe6160060
-
-u32 rcar_gen2_read_mode_pins(void)
-{
-	static u32 mode;
-	static bool mode_valid;
-
-	if (!mode_valid) {
-		void __iomem *modemr = ioremap_nocache(MODEMR, 4);
-		BUG_ON(!modemr);
-		mode = ioread32(modemr);
-		iounmap(modemr);
-		mode_valid = true;
-	}
-
-	return mode;
-}
-
 #define CNTCR 0
 #define CNTFID0 0x20
 
-- 
2.1.4

