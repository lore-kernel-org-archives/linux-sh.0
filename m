From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 02 Apr 2015 08:01:11 +0000
Subject: [PATCH] phy: phy-rcar-gen2: Fix USBHS_UGSTS_LOCK value
Message-Id: <1427961671-8064-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kishon@ti.com
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

According to the technical update (No. TN-RCS-B011A/E), the UGSTS LOCK
bit location is bit 8, not bits 1 and 0. It also says that the register
address offset of UGSTS is 0x88, not 0x90.
So, this patch fixes the USBHS_UGSTS_LOCK value and some comments.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/phy/phy-rcar-gen2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-rcar-gen2.c b/drivers/phy/phy-rcar-gen2.c
index 778276a..97d45f4 100644
--- a/drivers/phy/phy-rcar-gen2.c
+++ b/drivers/phy/phy-rcar-gen2.c
@@ -23,7 +23,7 @@
 #define USBHS_LPSTS			0x02
 #define USBHS_UGCTRL			0x80
 #define USBHS_UGCTRL2			0x84
-#define USBHS_UGSTS			0x88	/* The manuals have 0x90 */
+#define USBHS_UGSTS			0x88	/* From technical update */
 
 /* Low Power Status register (LPSTS) */
 #define USBHS_LPSTS_SUSPM		0x4000
@@ -41,7 +41,7 @@
 #define USBHS_UGCTRL2_USB0SEL_HS_USB	0x00000030
 
 /* USB General status register (UGSTS) */
-#define USBHS_UGSTS_LOCK		0x00000300 /* The manuals have 0x3 */
+#define USBHS_UGSTS_LOCK		0x00000100 /* From technical update */
 
 #define PHYS_PER_CHANNEL	2
 
-- 
1.9.1

