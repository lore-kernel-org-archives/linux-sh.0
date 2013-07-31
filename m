From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 31 Jul 2013 13:22:00 +0000
Subject: [PATCH v2 16/23] drm/rcar-du: Add support for the R8A7790 DU
Message-Id: <1375276927-20181-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375276927-20181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375276927-20181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The DU revision in the R8A7790 SoC uses one IRQ and clock per CRTC. Add
a corresponding entry in the module platform ID table.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c  |  5 +++
 drivers/gpu/drm/rcar-du/rcar_du_regs.h | 66 ++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index fd7cdda..381dbad 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -220,8 +220,13 @@ static const struct rcar_du_device_info rcar_du_r8a7779_info = {
 	.features = 0,
 };
 
+static const struct rcar_du_device_info rcar_du_r8a7790_info = {
+	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK,
+};
+
 static const struct platform_device_id rcar_du_id_table[] = {
 	{ "rcar-du-r8a7779", (kernel_ulong_t)&rcar_du_r8a7779_info },
+	{ "rcar-du-r8a7790", (kernel_ulong_t)&rcar_du_r8a7790_info },
 	{ }
 };
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_regs.h b/drivers/gpu/drm/rcar-du/rcar_du_regs.h
index 195ed7e..f62a9f3 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_regs.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_regs.h
@@ -196,6 +196,68 @@
 #define DEFR6_DEFAULT		(DEFR6_CODE | DEFR6_TCNE2)
 
 /* -----------------------------------------------------------------------------
+ * R8A7790-only Control Registers
+ */
+
+#define DD1SSR			0x20008
+#define DD1SSR_TVR		(1 << 15)
+#define DD1SSR_FRM		(1 << 14)
+#define DD1SSR_BUF		(1 << 12)
+#define DD1SSR_VBK		(1 << 11)
+#define DD1SSR_RINT		(1 << 9)
+#define DD1SSR_HBK		(1 << 8)
+#define DD1SSR_ADC(n)		(1 << ((n)-1))
+
+#define DD1SRCR			0x2000c
+#define DD1SRCR_TVR		(1 << 15)
+#define DD1SRCR_FRM		(1 << 14)
+#define DD1SRCR_BUF		(1 << 12)
+#define DD1SRCR_VBK		(1 << 11)
+#define DD1SRCR_RINT		(1 << 9)
+#define DD1SRCR_HBK		(1 << 8)
+#define DD1SRCR_ADC(n)		(1 << ((n)-1))
+
+#define DD1IER			0x20010
+#define DD1IER_TVR		(1 << 15)
+#define DD1IER_FRM		(1 << 14)
+#define DD1IER_BUF		(1 << 12)
+#define DD1IER_VBK		(1 << 11)
+#define DD1IER_RINT		(1 << 9)
+#define DD1IER_HBK		(1 << 8)
+#define DD1IER_ADC(n)		(1 << ((n)-1))
+
+#define DEFR8			0x20020
+#define DEFR8_CODE		(0x7790 << 16)
+#define DEFR8_VSCS		(1 << 6)
+#define DEFR8_DRGBS_DU(n)	((n) << 4)
+#define DEFR8_DRGBS_MASK	(3 << 4)
+#define DEFR8_DEFE8		(1 << 0)
+
+#define DOFLR			0x20024
+#define DOFLR_CODE		(0x7790 << 16)
+#define DOFLR_HSYCFL1		(1 << 13)
+#define DOFLR_VSYCFL1		(1 << 12)
+#define DOFLR_ODDFL1		(1 << 11)
+#define DOFLR_DISPFL1		(1 << 10)
+#define DOFLR_CDEFL1		(1 << 9)
+#define DOFLR_RGBFL1		(1 << 8)
+#define DOFLR_HSYCFL0		(1 << 5)
+#define DOFLR_VSYCFL0		(1 << 4)
+#define DOFLR_ODDFL0		(1 << 3)
+#define DOFLR_DISPFL0		(1 << 2)
+#define DOFLR_CDEFL0		(1 << 1)
+#define DOFLR_RGBFL0		(1 << 0)
+
+#define DIDSR			0x20028
+#define DIDSR_CODE		(0x7790 << 16)
+#define DIDSR_LCDS_DCLKIN(n)	(0 << (8 + (n) * 2))
+#define DIDSR_LCDS_LVDS0(n)	(2 << (8 + (n) * 2))
+#define DIDSR_LCDS_LVDS1(n)	(3 << (8 + (n) * 2))
+#define DIDSR_LCDS_MASK(n)	(3 << (8 + (n) * 2))
+#define DIDSR_PCDS_CLK(n, clk)	(clk << ((n) * 2))
+#define DIDSR_PCDS_MASK(n)	(3 << ((n) * 2))
+
+/* -----------------------------------------------------------------------------
  * Display Timing Generation Registers
  */
 
@@ -364,12 +426,10 @@
  * Display Capture Registers
  */
 
+#define DCMR			0x0c100
 #define DCMWR			0x0c104
-#define DC2MWR			0x0c204
 #define DCSAR			0x0c120
-#define DC2SAR			0x0c220
 #define DCMLR			0x0c150
-#define DC2MLR			0x0c250
 
 /* -----------------------------------------------------------------------------
  * Color Palette Registers
-- 
1.8.1.5

