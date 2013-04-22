From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:00:14 +0000
Subject: [PATCH 33/37] ARM: shmobile: r8a7740: Remove FSI function GPIOs
Message-Id: <1366671618-8796-34-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/r8a7740.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 4bec7cd..cb8e3fb 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -107,20 +107,6 @@ enum {
 	GPIO_FN_DBGMD10,	GPIO_FN_DBGMD11,	GPIO_FN_DBGMD20,
 	GPIO_FN_DBGMD21,
 
-	/* FSI-A */
-	GPIO_FN_FSIAISLD_PORT0,		/* FSIAISLD Port 0/5 */
-	GPIO_FN_FSIAISLD_PORT5,
-	GPIO_FN_FSIASPDIF_PORT9,	/* FSIASPDIF Port 9/18 */
-	GPIO_FN_FSIASPDIF_PORT18,
-	GPIO_FN_FSIAOSLD1,	GPIO_FN_FSIAOSLD2,
-	GPIO_FN_FSIAOLR,	GPIO_FN_FSIAOBT,
-	GPIO_FN_FSIAOSLD,	GPIO_FN_FSIAOMC,
-	GPIO_FN_FSIACK,		GPIO_FN_FSIAILR,
-	GPIO_FN_FSIAIBT,
-
-	/* FSI-B */
-	GPIO_FN_FSIBCK,
-
 	/* FMSI */
 	GPIO_FN_FMSISLD_PORT1, /* FMSISLD Port 1/6 */
 	GPIO_FN_FMSISLD_PORT6,
-- 
1.8.1.5

