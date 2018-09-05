From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 05 Sep 2018 20:30:32 +0000
Subject: [PATCH 1/2] clocksource: sh_cmt: properly line-wrap sh_cmt_of_table[] initializer
Message-Id: <bccdf54a-70ba-ea8e-275f-9382dab5f1d4@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <3ce24bfe-1edb-1a92-8847-ff998ac86d16@cogentembedded.com>
In-Reply-To: <3ce24bfe-1edb-1a92-8847-ff998ac86d16@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

There's no good reason for the sh_cmt_of_table[] initializer to
violate the 80-column limit, especially after the commit 8d50e9476bb4
("clocksource/drivers/sh_cmt: Mark "renesas,cmt-48-gen2" deprecated")
partially fixed it -- fix the R-Car gen2 related entries as well.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/clocksource/sh_cmt.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: renesas/drivers/clocksource/sh_cmt.c
=================================--- renesas.orig/drivers/clocksource/sh_cmt.c
+++ renesas/drivers/clocksource/sh_cmt.c
@@ -937,8 +937,14 @@ static const struct of_device_id sh_cmt_
 		.compatible = "renesas,cmt-48-gen2",
 		.data = &sh_cmt_info[SH_CMT0_RCAR_GEN2]
 	},
-	{ .compatible = "renesas,rcar-gen2-cmt0", .data = &sh_cmt_info[SH_CMT0_RCAR_GEN2] },
-	{ .compatible = "renesas,rcar-gen2-cmt1", .data = &sh_cmt_info[SH_CMT1_RCAR_GEN2] },
+	{
+		.compatible = "renesas,rcar-gen2-cmt0",
+		.data = &sh_cmt_info[SH_CMT0_RCAR_GEN2]
+	},
+	{
+		.compatible = "renesas,rcar-gen2-cmt1",
+		.data = &sh_cmt_info[SH_CMT1_RCAR_GEN2]
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sh_cmt_of_table);
