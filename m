From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:00:15 +0000
Subject: [PATCH 34/37] ARM: shmobile: r8a7740: Remove HDMI function GPIOs
Message-Id: <1366671618-8796-35-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/r8a7740.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index cb8e3fb..ed30a1d 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -300,10 +300,6 @@ enum {
 	GPIO_FN_RESETP_PULLUP,
 	GPIO_FN_RESETP_PLAIN,
 
-	/* HDMI */
-	GPIO_FN_HDMI_HPD,
-	GPIO_FN_HDMI_CEC,
-
 	/* SDENC */
 	GPIO_FN_SDENC_CPG,
 	GPIO_FN_SDENC_DV_CLKI,
-- 
1.8.1.5

