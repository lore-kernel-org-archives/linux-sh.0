From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 28 Feb 2014 21:09:28 +0000
Subject: [PATCH 4/4] ARM: shmobile: r7s72100: use workaround for non DT-clocks
Message-Id: <1393621768-12568-5-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

SCIF2 and MTU2 are not yet prepared for DT usage, so use the common
workaround via clkdev for now.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 arch/arm/mach-shmobile/board-genmai-reference.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c b/arch/arm/mach-shmobile/board-genmai-reference.c
index 7630c10..91dcdd0 100644
--- a/arch/arm/mach-shmobile/board-genmai-reference.c
+++ b/arch/arm/mach-shmobile/board-genmai-reference.c
@@ -18,18 +18,29 @@
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
+	{ "mtu2", NULL, "sh_mtu2.0" },
+	{ "scif2", NULL, "sh-sci.2" },
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
1.8.5.1

