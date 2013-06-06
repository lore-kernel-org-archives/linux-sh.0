From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Jun 2013 07:28:34 +0000
Subject: [PATCH 21/23] ARM: shmobile: sh73a0: Always use shmobile_setup_delay()
Message-Id: <1370503716-31155-22-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1370503716-31155-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1370503716-31155-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Break out the function sh73a0_init_delay() that now
gets called both for the C version of the code and
the DT -reference boards. This way we handle both
cases in the same way.

Allows us to boot with TWD only in the kernel configuration
for C board code. TWD is not yet enabled in the case of
DT -reference - this due to a dependency on CCF.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index ed93e01..bea298e 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -982,11 +982,17 @@ void __init sh73a0_add_standard_devices(void)
 			    ARRAY_SIZE(sh73a0_late_devices));
 }
 
+void __init sh73a0_init_delay(void)
+{
+	shmobile_setup_delay(1196, 44, 46); /* Cortex-A9 @ 1196MHz */
+}
+
 /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
 void __init __weak sh73a0_register_twd(void) { }
 
 void __init sh73a0_earlytimer_init(void)
 {
+	sh73a0_init_delay();
 	sh73a0_clock_init();
 	shmobile_earlytimer_init();
 	sh73a0_register_twd();
@@ -1005,11 +1011,6 @@ void __init sh73a0_add_early_devices(void)
 
 #ifdef CONFIG_USE_OF
 
-void __init sh73a0_init_delay(void)
-{
-	shmobile_setup_delay(1196, 44, 46); /* Cortex-A9 @ 1196MHz */
-}
-
 static const struct of_dev_auxdata sh73a0_auxdata_lookup[] __initconst = {
 	{},
 };
-- 
1.8.2.1

