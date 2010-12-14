From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 14 Dec 2010 07:57:03 +0000
Subject: [PATCH 02/03] ARM: mach-shmobile: Enable SMP support
Message-Id: <20101214075703.11275.42101.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20101214075647.11275.25933.sendpatchset@t400s>
In-Reply-To: <20101214075647.11275.25933.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Allow SMP to be enabled on R-Mobile / SH-Mobile.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 May need to be reworked to fit the current state of the tree
 associated with the RMK patch tracker.

 arch/arm/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 0001/arch/arm/Kconfig
+++ work/arch/arm/Kconfig	2010-12-14 13:31:02.000000000 +0900
@@ -1211,7 +1211,8 @@ config SMP
 	depends on GENERIC_CLOCKEVENTS
 	depends on REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP || \
 		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 ||\
-		 ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4
+		 ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
+		 ARCH_SHMOBILE
 	select USE_GENERIC_SMP_HELPERS
 	select HAVE_ARM_SCU
 	help
