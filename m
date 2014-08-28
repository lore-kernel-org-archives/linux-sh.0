From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 Aug 2014 03:35:09 +0000
Subject: [PATCH 03/05] ARM: shmobile: r8a7740: Add restart callback
Message-Id: <20140828033509.18867.72827.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Port the r8a7740 restart handling from the Armadillo code
to the r8a7740 generic multiplatform case.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7740.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- 0001/arch/arm/mach-shmobile/setup-r8a7740.c
+++ work/arch/arm/mach-shmobile/setup-r8a7740.c	2014-08-27 18:40:36.000000000 +0900
@@ -823,6 +823,13 @@ static void __init r8a7740_generic_init(
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
+#define RESCNT2 IOMEM(0xe6188020)
+static void r8a7740_restart(enum reboot_mode mode, const char *cmd)
+{
+	/* Do soft power on reset */
+	writel(1 << 31, RESCNT2);
+}
+
 static const char *r8a7740_boards_compat_dt[] __initdata = {
 	"renesas,r8a7740",
 	NULL,
@@ -835,6 +842,7 @@ DT_MACHINE_START(R8A7740_DT, "Generic R8
 	.init_machine	= r8a7740_generic_init,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a7740_boards_compat_dt,
+	.restart	= r8a7740_restart,
 MACHINE_END
 
 #endif /* CONFIG_USE_OF */
