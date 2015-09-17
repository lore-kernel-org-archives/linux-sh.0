From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Sep 2015 09:53:44 +0000
Subject: [PATCH v2 02/11] clocksource: sh_cmt: Use 0x3f mask for SH_CMT_48BIT case
Message-Id: <20150917095344.5369.2009.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917095325.5369.73893.sendpatchset@little-apple>
In-Reply-To: <20150917095325.5369.73893.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

Always use 0x3f as channel mask for the SH_CMT_48BIT type of devices.
Once this patch is applied the "renesas,channels-mask" property will
be ignored by the driver for older devices matching SH_CMT_48BIT. In
the future when all CMT types store channel mask in the driver then
we will be able to deprecate and remove "renesas,channels-mask" from DTS.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

 Changes since V1:
 - Fixed compile error - thanks Geert!
 - Added Acked-by and Tested-by from Geert
 - Added Acked-by from Laurent

drivers/clocksource/sh_cmt.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- 0001/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2015-09-17 17:25:15.820513000 +0900
@@ -74,6 +74,8 @@ enum sh_cmt_model {
 struct sh_cmt_info {
 	enum sh_cmt_model model;
 
+	unsigned long channels_mask;
+
 	unsigned long width; /* 16 or 32 bit version of hardware block */
 	unsigned long overflow_bit;
 	unsigned long clear_bits;
@@ -212,6 +214,7 @@ static const struct sh_cmt_info sh_cmt_i
 	},
 	[SH_CMT_48BIT] = {
 		.model = SH_CMT_48BIT,
+		.channels_mask = 0x3f,
 		.width = 32,
 		.overflow_bit = SH_CMT32_CMCSR_CMF,
 		.clear_bits = ~(SH_CMT32_CMCSR_CMF | SH_CMT32_CMCSR_OVF),
@@ -972,9 +975,14 @@ static int sh_cmt_setup(struct sh_cmt_de
 		id = of_match_node(sh_cmt_of_table, pdev->dev.of_node);
 		cmt->info = id->data;
 
-		ret = sh_cmt_parse_dt(cmt);
-		if (ret < 0)
-			return ret;
+		/* prefer in-driver channel configuration over DT */
+		if (cmt->info->channels_mask) {
+			cmt->hw_channels = cmt->info->channels_mask;
+		} else {
+			ret = sh_cmt_parse_dt(cmt);
+			if (ret < 0)
+				return ret;
+		}
 	} else if (pdev->dev.platform_data) {
 		struct sh_timer_config *cfg = pdev->dev.platform_data;
 		const struct platform_device_id *id = pdev->id_entry;
