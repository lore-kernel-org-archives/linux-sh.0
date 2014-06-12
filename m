From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 12 Jun 2014 08:42:24 +0000
Subject: [PATCH 3/3] ARM: shmobile: rcar-gen2: Remove useless copied section for LongTrail
Message-Id: <1402562544-4527-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Open Firmware in the CHRP LongTrail does not support plugging in ARM CPUs
in its PPC 603e/604e-compatible CPU socket ;-)

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index e308bdb9ae4d..3223ccd21f00 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -129,14 +129,7 @@ static int __init rcar_gen2_scan_mem(unsigned long node, const char *uname,
 	u64 lpae_start = 1ULL << 32;
 
 	/* We are scanning "memory" nodes only */
-	if (type = NULL) {
-		/*
-		 * The longtrail doesn't have a device_type on the
-		 * /memory node, so look for the node called /memory@0.
-		 */
-		if (depth != 1 || strcmp(uname, "memory@0") != 0)
-			return 0;
-	} else if (strcmp(type, "memory") != 0)
+	if (type = NULL || strcmp(type, "memory"))
 		return 0;
 
 	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
-- 
1.9.1

