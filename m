From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 19 May 2014 23:37:33 +0000
Subject: [PATCH 02/03] ARM: shmobile: Use r8a7790 DT CPU Frequency for Lager
Message-Id: <20140519233733.10496.73276.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20140519233714.10496.31390.sendpatchset@w520>
In-Reply-To: <20140519233714.10496.31390.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Convert the Lager board support to use shmobile_init_delay()
to be able to migrate away from per-SoC delay setup functions.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/board-lager-reference.c |    2 +-
 arch/arm/mach-shmobile/board-lager.c           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-05-19 22:21:00.000000000 +0900
@@ -115,7 +115,7 @@ static const char *lager_boards_compat_d
 
 DT_MACHINE_START(LAGER_DT, "lager")
 	.smp		= smp_ops(r8a7790_smp_ops),
-	.init_early	= r8a7790_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= lager_add_standard_devices,
 	.init_late	= shmobile_init_late,
--- 0001/arch/arm/mach-shmobile/board-lager.c
+++ work/arch/arm/mach-shmobile/board-lager.c	2014-05-19 22:21:20.000000000 +0900
@@ -886,7 +886,7 @@ static const char * const lager_boards_c
 
 DT_MACHINE_START(LAGER_DT, "lager")
 	.smp		= smp_ops(r8a7790_smp_ops),
-	.init_early	= r8a7790_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= lager_init,
 	.init_late	= shmobile_init_late,
