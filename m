From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 24 Feb 2016 08:43:23 +0000
Subject: [PATCH] drivers: sh: Restore legacy clock domain on SuperH platforms
Message-Id: <1456303403-22803-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Hans Verkuil <hverkuil@xs4all.nl>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

CONFIG_ARCH_SHMOBILE is not only enabled for Renesas ARM platforms
(which are DT based and multi-platform), but also on a select set of
Renesas SuperH platforms (SH7722/SH7723/SH7724/SH7343/SH7366). Hence
since commit 0ba58de231066e47 ("drivers: sh: Get rid of
CONFIG_ARCH_SHMOBILE_MULTI"), the legacy clock domain is no longer
installed on these SuperH platforms, and module clocks may not be
enabled when needed, leading to driver failures.

To fix this, add an additional check for CONFIG_OF.

Fixes: 0ba58de231066e47 ("drivers: sh: Get rid of CONFIG_ARCH_SHMOBILE_MULTI").
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Verified by looking at the resulting assembler output.
Not run-tested due to lack of hardware.

This is meant to be applied to stable (v4.4 and up), and to whatever
tree the original commit was backported to.

I didn't just change the test to ARCH_RENESAS, as that symbol does not
exist in v4.4.
---
 drivers/sh/pm_runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index 91a003011acfacb2..a9bac3bf20de14e5 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -34,7 +34,7 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
 
 static int __init sh_pm_runtime_init(void)
 {
-	if (IS_ENABLED(CONFIG_ARCH_SHMOBILE)) {
+	if (IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_ARCH_SHMOBILE)) {
 		if (!of_find_compatible_node(NULL, NULL,
 					     "renesas,cpg-mstp-clocks"))
 			return 0;
-- 
1.9.1

