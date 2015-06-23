From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 23 Jun 2015 12:56:28 +0000
Subject: [PATCH 1/2] clocksource: sh_cmt: Remove obsolete sh-cmt-32-fast platform_device_id entry
Message-Id: <1435064189-10889-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Since commit 59b89af1d5551c12 ("ARM: shmobile: sh7372: Remove Legacy C
SoC code"), there are no more users left of the "sh-cmt-32-fast"
platform device name. Hence remove the corresponding platform_device_id
entry from the driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clocksource/sh_cmt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index c96de14036a0adeb..c123eb5c3e28c868 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -935,7 +935,6 @@ static int sh_cmt_map_memory(struct sh_cmt_device *cmt)
 static const struct platform_device_id sh_cmt_id_table[] = {
 	{ "sh-cmt-16", (kernel_ulong_t)&sh_cmt_info[SH_CMT_16BIT] },
 	{ "sh-cmt-32", (kernel_ulong_t)&sh_cmt_info[SH_CMT_32BIT] },
-	{ "sh-cmt-32-fast", (kernel_ulong_t)&sh_cmt_info[SH_CMT_32BIT_FAST] },
 	{ "sh-cmt-48", (kernel_ulong_t)&sh_cmt_info[SH_CMT_48BIT] },
 	{ "sh-cmt-48-gen2", (kernel_ulong_t)&sh_cmt_info[SH_CMT_48BIT_GEN2] },
 	{ }
-- 
1.9.1

