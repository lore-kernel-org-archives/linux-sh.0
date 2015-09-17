From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Sep 2015 09:55:01 +0000
Subject: [PATCH v2 10/11] clocksource: sh_cmt: Remove unused 32-bit CMT bindings
Message-Id: <20150917095501.5369.97124.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917095325.5369.73893.sendpatchset@little-apple>
In-Reply-To: <20150917095325.5369.73893.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

Remove the 32-bit CMT compat strings to reduce maintenance burden.

It should be fine to break DT compatibility because the 32-bit
32-bit CMT DT binding was never part of any upstream DTS file.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - New patch

 drivers/clocksource/sh_cmt.c |    2 --
 1 file changed, 2 deletions(-)

--- 0005/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2015-09-17 18:06:35.940513000 +0900
@@ -957,8 +957,6 @@ static const struct platform_device_id s
 MODULE_DEVICE_TABLE(platform, sh_cmt_id_table);
 
 static const struct of_device_id sh_cmt_of_table[] __maybe_unused = {
-	{ .compatible = "renesas,cmt-32", .data = &sh_cmt_info[SH_CMT_32BIT] },
-	{ .compatible = "renesas,cmt-32-fast", .data = &sh_cmt_info[SH_CMT_32BIT_FAST] },
 	{ .compatible = "renesas,cmt-48", .data = &sh_cmt_info[SH_CMT_48BIT] },
 	{ .compatible = "renesas,cmt-48-gen2", .data = &sh_cmt_info[SH_CMT0_RCAR_GEN2] },
 	{ .compatible = "renesas,cmt0-rcar-gen2", .data = &sh_cmt_info[SH_CMT0_RCAR_GEN2] },
