From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 27 Jun 2013 09:49:26 +0000
Subject: [PATCH 16/24] drm/rcar-du: Remove register definitions for the second channel
Message-Id: <1372326574-4315-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Channels are accessed through a global channel memory offset, there's no
need to define register addresses for the second channel.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_regs.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_regs.h b/drivers/gpu/drm/rcar-du/rcar_du_regs.h
index 3aba27f..195ed7e 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_regs.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_regs.h
@@ -20,7 +20,6 @@
  */
 
 #define DSYSR			0x00000	/* display 1 */
-#define D2SYSR			0x30000	/* display 2 */
 #define DSYSR_ILTS		(1 << 29)
 #define DSYSR_DSEC		(1 << 20)
 #define DSYSR_IUPD		(1 << 16)
@@ -35,7 +34,6 @@
 #define DSYSR_SCM_INT_VIDEO	(3 << 4)
 
 #define DSMR			0x00004
-#define D2SMR			0x30004
 #define DSMR_VSPM		(1 << 28)
 #define DSMR_ODPM		(1 << 27)
 #define DSMR_DIPM_DISP		(0 << 25)
@@ -60,7 +58,6 @@
 #define DSMR_CSY_MASK		(3 << 6)
 
 #define DSSR			0x00008
-#define D2SSR			0x30008
 #define DSSR_VC1FB_DSA0		(0 << 30)
 #define DSSR_VC1FB_DSA1		(1 << 30)
 #define DSSR_VC1FB_DSA2		(2 << 30)
@@ -80,7 +77,6 @@
 #define DSSR_ADC(n)		(1 << ((n)-1))
 
 #define DSRCR			0x0000c
-#define D2SRCR			0x3000c
 #define DSRCR_TVCL		(1 << 15)
 #define DSRCR_FRCL		(1 << 14)
 #define DSRCR_VBCL		(1 << 11)
@@ -90,7 +86,6 @@
 #define DSRCR_MASK		0x0000cbff
 
 #define DIER			0x00010
-#define D2IER			0x30010
 #define DIER_TVE		(1 << 15)
 #define DIER_FRE		(1 << 14)
 #define DIER_VBE		(1 << 11)
@@ -114,7 +109,6 @@
 #define DPPR_BPP32		(DPPR_BPP32_P1 | DPPR_BPP32_P2)	/* plane1 & 2 */
 
 #define DEFR			0x00020
-#define D2EFR			0x30020
 #define DEFR_CODE		(0x7773 << 16)
 #define DEFR_EXSL		(1 << 12)
 #define DEFR_EXVL		(1 << 11)
@@ -137,12 +131,10 @@
 #define DCPCR_DCE		(1 << 0)
 
 #define DEFR2			0x00034
-#define D2EFR2			0x30034
 #define DEFR2_CODE		(0x7775 << 16)
 #define DEFR2_DEFE2G		(1 << 0)
 
 #define DEFR3			0x00038
-#define D2EFR3			0x30038
 #define DEFR3_CODE		(0x7776 << 16)
 #define DEFR3_EVDA		(1 << 14)
 #define DEFR3_EVDM_1		(1 << 12)
@@ -153,7 +145,6 @@
 #define DEFR3_DEFE3		(1 << 0)
 
 #define DEFR4			0x0003c
-#define D2EFR4			0x3003c
 #define DEFR4_CODE		(0x7777 << 16)
 #define DEFR4_LRUO		(1 << 5)
 #define DEFR4_SPCE		(1 << 4)
-- 
1.8.1.5

