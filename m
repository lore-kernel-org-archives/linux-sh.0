From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 15 Sep 2014 13:35:36 +0000
Subject: [PATCH] ARM: shmobile: r8a7794: Reserve memory as other R-Car Gen2 SoCs
Message-Id: <20140915133536.21371.34861.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Other R-Car Gen2 SoCs such as r8a7790 and r8a7791 reserve
the top 256 MiB of memory for use with CMA. Adjust the
board-less r8a7794 code to do the same.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7794.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/mach-shmobile/setup-r8a7794.c
+++ work/arch/arm/mach-shmobile/setup-r8a7794.c	2014-09-15 18:29:21.000000000 +0900
@@ -28,5 +28,6 @@ DT_MACHINE_START(R8A7794_DT, "Generic R8
 	.init_early	= shmobile_init_delay,
 	.init_late	= shmobile_init_late,
 	.init_time	= rcar_gen2_timer_init,
+	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= r8a7794_boards_compat_dt,
 MACHINE_END
