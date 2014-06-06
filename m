From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 06 Jun 2014 06:15:23 +0000
Subject: [PATCH] ARM: shmobile: Use shmobile_init_late() on r8a7791 DT-only
Message-Id: <20140606061523.13394.1268.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20140511231050.19908.86623.sendpatchset@w520>
In-Reply-To: <20140511231050.19908.86623.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Tie in shmobile_init_late for the DT-only r8a7791 SoC
Multiplatform support code. This will make sure that
Suspend-to-RAM, CPUIdle and CPUFreq get initialized.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7791.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/mach-shmobile/setup-r8a7791.c
+++ work/arch/arm/mach-shmobile/setup-r8a7791.c	2014-06-06 14:41:04.000000000 +0900
@@ -217,6 +217,7 @@ DT_MACHINE_START(R8A7791_DT, "Generic R8
 	.smp		= smp_ops(r8a7791_smp_ops),
 	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a7791_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
