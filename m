From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 05 Jun 2013 08:26:24 +0000
Subject: [PATCH 093/130] ARM: shmobile: r8a7740: Remove HDMI function GPIOs
Message-Id: <1370420821-28420-94-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7740.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 001302f..55f3d1a 100644
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
1.8.2.1

