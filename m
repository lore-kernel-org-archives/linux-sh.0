From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 05 Apr 2013 04:24:27 +0000
Subject: [PATCH 5/5 v2] ARM: shmobile: ape6evm: MP clock parent become EXTAL2
Message-Id: <87k3ohk3k8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The orignal commit 3263e09d287fbaa8a9424b5e69396599a3bbd518
(ARM: shmobile: Initial r8a73a4 SoC support V3)
put MP clock parent as EXTAL2, but its code was removed
on DIV6 clock support commit.
This patch makes it consistent.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - it used IS_ERR() for checking

>> Simon

I guess we don't need this patch,
because MP default parent is EXTAL2...
I'm not sure why Magnus set it in original patch

 arch/arm/mach-shmobile/board-ape6evm.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 55b8c9f..5eb0caa 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
+#include <linux/sh_clk.h>
 #include <linux/smsc911x.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
@@ -65,7 +66,21 @@ static const struct pinctrl_map ape6evm_pinctrl_map[] = {
 
 static void __init ape6evm_add_standard_devices(void)
 {
+
+	struct clk *parent;
+	struct clk *mp;
+
 	r8a73a4_clock_init();
+
+	/* MP clock parent = extal2 */
+	parent      = clk_get(NULL, "extal2");
+	mp          = clk_get(NULL, "mp");
+	BUG_ON(IS_ERR(parent) || IS_ERR(mp));
+
+	clk_set_parent(mp, parent);
+	clk_put(parent);
+	clk_put(mp);
+
 	pinctrl_register_mappings(ape6evm_pinctrl_map,
 				  ARRAY_SIZE(ape6evm_pinctrl_map));
 	r8a73a4_pinmux_init();
-- 
1.7.9.5

