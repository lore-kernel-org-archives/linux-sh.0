From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 20 Nov 2015 00:39:10 +0000
Subject: [PATCH] drivers: sh: Get rid of CONFIG_ARCH_SHMOBILE_MULTI
Message-Id: <0ba58de231066e47de87ccc4d61c5e396fe9bd27.1447979812.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1447979812.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1447979812.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>

From: Geert Uytterhoeven <geert+renesas@glider.be>

Shmobile is all multiplatform these days, so get rid of the reference to
CONFIG_ARCH_SHMOBILE_MULTI.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/sh/pm_runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index 25abd4eb7d10..91a003011acf 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -34,7 +34,7 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
 
 static int __init sh_pm_runtime_init(void)
 {
-	if (IS_ENABLED(CONFIG_ARCH_SHMOBILE_MULTI)) {
+	if (IS_ENABLED(CONFIG_ARCH_SHMOBILE)) {
 		if (!of_find_compatible_node(NULL, NULL,
 					     "renesas,cpg-mstp-clocks"))
 			return 0;
-- 
2.1.4

