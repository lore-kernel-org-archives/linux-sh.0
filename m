From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Dec 2011 16:52:31 +0000
Subject: [PATCH 04/07] ARM: mach-shmobile: Marzen early console hack
Message-Id: <20111206165231.19348.35940.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Hack the Marzen board code to get early debug print outs.
Use with "earlyprint=sh-sci.2,11520" on the kernel command line.

Good to have when tracking down early timer or PFC issues.

Needed by the r8a7779 PFC map hack further in the series.

Never-signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-marzen.c  |    8 ++++++++
 arch/arm/mach-shmobile/setup-r8a7779.c |    4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

--- 0008/arch/arm/mach-shmobile/board-marzen.c
+++ work/arch/arm/mach-shmobile/board-marzen.c	2011-12-06 23:57:23.000000000 +0900
@@ -54,6 +54,13 @@ static struct map_desc marzen_io_desc[]
 		.length		= SZ_16M,
 		.type		= MT_DEVICE_NONSHARED
 	},
+	/* 16M debug map between 0xfdxxxxxx and 0xffxxxxxx */
+	{
+		.virtual	= 0xfd000000,
+		.pfn		= __phys_to_pfn(0xff000000),
+		.length		= SZ_16M,
+		.type		= MT_DEVICE_NONSHARED
+	},
 };
 
 static void __init marzen_map_io(void)
@@ -80,6 +87,7 @@ static void __init marzen_init_early(voi
 	 * As a final step pass earlyprint=sh-sci.2,115200 on the kernel
 	 * command line.
 	 */
+	shmobile_setup_console();
 }
 
 static void __init marzen_init(void)
--- 0008/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2011-12-06 23:56:32.000000000 +0900
@@ -70,8 +70,8 @@ static struct platform_device scif1_devi
 };
 
 static struct plat_sci_port scif2_platform_data = {
-	.mapbase	= 0xffe42000,
-	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.mapbase	= 0xfde42000,
+	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
