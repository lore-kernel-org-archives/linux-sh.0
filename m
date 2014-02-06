From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Feb 2014 06:19:00 +0000
Subject: [PATCH 08/21] ARM: shmobile: kzm9d: Use common clock framework
Message-Id: <ef5ecd1f20de2d1919714f029f5016bf6d061e66.1391665225.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1391665225.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

Use common clock framework version of clock
 drivers/clk/shmobile/clk-emev2.c
instead of sh-clkfwk version
 arch/arm/mach-shmobile/clock-emev2.c
when it is configured as a part of multi-platform.

Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9d-reference.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9d-reference.c b/arch/arm/mach-shmobile/board-kzm9d-reference.c
index 054d8d5..853003c 100644
--- a/arch/arm/mach-shmobile/board-kzm9d-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9d-reference.c
@@ -20,15 +20,14 @@
 
 #include <linux/init.h>
 #include <linux/of_platform.h>
+#include <linux/clk-provider.h>
 #include <mach/emev2.h>
 #include <mach/common.h>
 #include <asm/mach/arch.h>
 
 static void __init kzm9d_add_standard_devices(void)
 {
-	if (!IS_ENABLED(CONFIG_COMMON_CLK))
-		emev2_clock_init();
-
+	of_clk_init(NULL);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.8.5.2

