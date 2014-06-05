From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Jun 2014 05:16:09 +0000
Subject: [PATCH 08/08] ARM: shmobile: Use shmobile_init_late on r8a7790 DT-only
Message-Id: <20140605051609.18075.66159.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Tie in shmobile_init_late for the DT-only r8a7790 SoC
Multiplatform support code. This will make sure that
Suspend-to-RAM, CPUIdle and CPUFreq get initialized.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7790.c |    1 +
 1 file changed, 1 insertion(+)

--- 0008/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2014-06-05 12:55:21.000000000 +0900
@@ -325,6 +325,7 @@ DT_MACHINE_START(R8A7790_DT, "Generic R8
 	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= r8a7790_init_machine,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a7790_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
