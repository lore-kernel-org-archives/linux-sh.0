From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Wed, 17 Dec 2014 16:18:53 +0000
Subject: [PATCH v4 5/6] ARM: shmobile: ape6evm: disable legacy clock initialization
Message-Id: <1418833134-7863-6-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Disables r8a73a4_clock_init() if CCF is enabled.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/board-ape6evm-reference.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
index 3b68370..dd5bc63 100644
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
@@ -29,7 +29,7 @@
 
 static void __init ape6evm_add_standard_devices(void)
 {
-
+#ifndef CONFIG_COMMON_CLK
 	struct clk *parent;
 	struct clk *mp;
 
@@ -43,6 +43,7 @@ static void __init ape6evm_add_standard_devices(void)
 	clk_set_parent(mp, parent);
 	clk_put(parent);
 	clk_put(mp);
+#endif
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
-- 
1.8.4.5

