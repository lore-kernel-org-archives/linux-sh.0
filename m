From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Sep 2015 09:54:03 +0000
Subject: [PATCH v2 04/11] clocksource: sh_cmt: Support separate R-Car Gen2 CMT0/1
Message-Id: <20150917095403.5369.97011.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917095325.5369.73893.sendpatchset@little-apple>
In-Reply-To: <20150917095325.5369.73893.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

Add support for the new R-Car Gen2 CMT0 and CMT1 bindings. Support
for the old DT binding is still kept around, however devices using
such binding will be treated as a low-feature CMT0 device. If users
want to make use of CMT1-specific features then they need to update
their DTBs. No special CMT1-specific features are however implemented
by his patch, only DT bindings are redone as groundwork for future
feature patches.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

 Changes since V1:
 - Added Acked-by and Tested-by from Geert
 - Added Acked-by from Laurent

 drivers/clocksource/sh_cmt.c |   38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

--- 0003/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2015-09-17 17:28:33.380513000 +0900
@@ -39,16 +39,16 @@ struct sh_cmt_device;
  * SoC but also on the particular instance. The following table lists the main
  * characteristics of those flavours.
  *
- *			16B	32B	32B-F	48B	48B-2
+ *			16B	32B	32B-F	48B	R-Car Gen2
  * -----------------------------------------------------------------------------
  * Channels		2	1/4	1	6	2/8
  * Control Width	16	16	16	16	32
  * Counter Width	16	32	32	32/48	32/48
  * Shared Start/Stop	Y	Y	Y	Y	N
  *
- * The 48-bit gen2 version has a per-channel start/stop register located in the
- * channel registers block. All other versions have a shared start/stop register
- * located in the global space.
+ * The r8a73a4 / R-Car Gen2 version has a per-channel start/stop register
+ * located in the channel registers block. All other versions have a shared
+ * start/stop register located in the global space.
  *
  * Channels are indexed from 0 to N-1 in the documentation. The channel index
  * infers the start/stop bit position in the control register and the channel
@@ -68,7 +68,8 @@ enum sh_cmt_model {
 	SH_CMT_32BIT,
 	SH_CMT_32BIT_FAST,
 	SH_CMT_48BIT,
-	SH_CMT_48BIT_GEN2,
+	SH_CMT0_RCAR_GEN2,
+	SH_CMT1_RCAR_GEN2,
 };
 
 struct sh_cmt_info {
@@ -223,8 +224,20 @@ static const struct sh_cmt_info sh_cmt_i
 		.read_count = sh_cmt_read32,
 		.write_count = sh_cmt_write32,
 	},
-	[SH_CMT_48BIT_GEN2] = {
-		.model = SH_CMT_48BIT_GEN2,
+	[SH_CMT0_RCAR_GEN2] = {
+		.model = SH_CMT0_RCAR_GEN2,
+		.channels_mask = 0x60,
+		.width = 32,
+		.overflow_bit = SH_CMT32_CMCSR_CMF,
+		.clear_bits = ~(SH_CMT32_CMCSR_CMF | SH_CMT32_CMCSR_OVF),
+		.read_control = sh_cmt_read32,
+		.write_control = sh_cmt_write32,
+		.read_count = sh_cmt_read32,
+		.write_count = sh_cmt_write32,
+	},
+	[SH_CMT1_RCAR_GEN2] = {
+		.model = SH_CMT1_RCAR_GEN2,
+		.channels_mask = 0xff,
 		.width = 32,
 		.overflow_bit = SH_CMT32_CMCSR_CMF,
 		.clear_bits = ~(SH_CMT32_CMCSR_CMF | SH_CMT32_CMCSR_OVF),
@@ -867,6 +880,7 @@ static int sh_cmt_setup_channel(struct s
 	ch->cmt = cmt;
 	ch->index = index;
 	ch->hwidx = hwidx;
+	ch->timer_bit = hwidx;
 
 	/*
 	 * Compute the address of the channel control register block. For the
@@ -888,9 +902,11 @@ static int sh_cmt_setup_channel(struct s
 		 */
 		ch->ioctrl = cmt->mapbase + 0x40;
 		break;
-	case SH_CMT_48BIT_GEN2:
+	case SH_CMT0_RCAR_GEN2:
+	case SH_CMT1_RCAR_GEN2:
 		ch->iostart = cmt->mapbase + ch->hwidx * 0x100;
 		ch->ioctrl = ch->iostart + 0x10;
+		ch->timer_bit = 0;
 		break;
 	}
 
@@ -902,8 +918,6 @@ static int sh_cmt_setup_channel(struct s
 	ch->match_value = ch->max_match_value;
 	raw_spin_lock_init(&ch->lock);
 
-	ch->timer_bit = cmt->info->model = SH_CMT_48BIT_GEN2 ? 0 : ch->hwidx;
-
 	ret = sh_cmt_register(ch, dev_name(&cmt->pdev->dev),
 			      clockevent, clocksource);
 	if (ret) {
@@ -946,7 +960,9 @@ static const struct of_device_id sh_cmt_
 	{ .compatible = "renesas,cmt-32", .data = &sh_cmt_info[SH_CMT_32BIT] },
 	{ .compatible = "renesas,cmt-32-fast", .data = &sh_cmt_info[SH_CMT_32BIT_FAST] },
 	{ .compatible = "renesas,cmt-48", .data = &sh_cmt_info[SH_CMT_48BIT] },
-	{ .compatible = "renesas,cmt-48-gen2", .data = &sh_cmt_info[SH_CMT_48BIT_GEN2] },
+	{ .compatible = "renesas,cmt-48-gen2", .data = &sh_cmt_info[SH_CMT0_RCAR_GEN2] },
+	{ .compatible = "renesas,cmt0-rcar-gen2", .data = &sh_cmt_info[SH_CMT0_RCAR_GEN2] },
+	{ .compatible = "renesas,cmt1-rcar-gen2", .data = &sh_cmt_info[SH_CMT1_RCAR_GEN2] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sh_cmt_of_table);
