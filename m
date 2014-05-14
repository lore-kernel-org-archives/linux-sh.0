From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 14 May 2014 01:10:15 +0000
Subject: [PATCH v6 11/12] ARM: shmobile: r7s72100: use workaround for non DT-clocks
Message-Id: <1400029816-24028-12-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1400029816-24028-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1400029816-24028-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

MTU2 is not yet prepared for DT usage, so use the common workaround via
clkdev for now.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/mach-shmobile/board-genmai-reference.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c b/arch/arm/mach-shmobile/board-genmai-reference.c
index 7630c1053e32..33015e5ed52a 100644
--- a/arch/arm/mach-shmobile/board-genmai-reference.c
+++ b/arch/arm/mach-shmobile/board-genmai-reference.c
@@ -18,18 +18,28 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <linux/clk-provider.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/r7s72100.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#ifdef CONFIG_COMMON_CLK
+/*
+ * This is a really crude hack to provide clkdev support to platform
+ * devices until they get moved to DT.
+ */
+static const struct clk_name clk_names[] = {
+	{ "mtu2", "fck", "sh-mtu2" },
+};
+#endif
+
 static void __init genmai_add_standard_devices(void)
 {
 #ifdef CONFIG_COMMON_CLK
-	of_clk_init(NULL);
+	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), true);
 #else
 	r7s72100_clock_init();
 #endif
-- 
1.9.2

