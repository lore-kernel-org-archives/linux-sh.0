From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 14 Jul 2015 12:00:47 +0000
Subject: [PATCH] clocksource: sh_cmt: Remove obsolete sh-cmt-48 platform_device_id entry
Message-Id: <1436875247-14130-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Since the removal of the r8a7740 legacy SoC code in commit
44d88c754e57a6d9 ("ARM: shmobile: Remove legacy SoC code for R-Mobile
A1"), all former users of the "sh-cmt-48-gen2" platform device name are
only supported in generic DT-only ARM multi-platform builds.  The driver
doesn't need to match platform devices by name anymore, hence remove the
corresponding platform_device_id entry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
The commit mentioned above is in -next, destined for v4.3.
---
 drivers/clocksource/sh_cmt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index ef799532a7a7963e..e4138e2a88f56b4e 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -935,7 +935,6 @@ static int sh_cmt_map_memory(struct sh_cmt_device *cmt)
 static const struct platform_device_id sh_cmt_id_table[] = {
 	{ "sh-cmt-16", (kernel_ulong_t)&sh_cmt_info[SH_CMT_16BIT] },
 	{ "sh-cmt-32", (kernel_ulong_t)&sh_cmt_info[SH_CMT_32BIT] },
-	{ "sh-cmt-48", (kernel_ulong_t)&sh_cmt_info[SH_CMT_48BIT] },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, sh_cmt_id_table);
-- 
1.9.1

