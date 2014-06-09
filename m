From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 09 Jun 2014 12:38:53 +0000
Subject: [PATCH 02/02] ARM: shmobile: Enable R-Car Gen2 CMA code in board files
Message-Id: <20140609123853.31532.58407.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook in the R-Car Gen2 CMA reservation code in the board
files for Lager and Koelsch. Both the DT-reference code
and the legacy code is modified.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/board-koelsch-reference.c |    1 +
 arch/arm/mach-shmobile/board-koelsch.c           |    1 +
 arch/arm/mach-shmobile/board-lager-reference.c   |    1 +
 arch/arm/mach-shmobile/board-lager.c             |    1 +
 4 files changed, 4 insertions(+)

--- 0001/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ work/arch/arm/mach-shmobile/board-koelsch-reference.c	2014-06-09 21:06:57.000000000 +0900
@@ -113,5 +113,6 @@ DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= koelsch_add_standard_devices,
 	.init_late	= shmobile_init_late,
+	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= koelsch_boards_compat_dt,
 MACHINE_END
--- 0001/arch/arm/mach-shmobile/board-koelsch.c
+++ work/arch/arm/mach-shmobile/board-koelsch.c	2014-06-09 21:06:49.000000000 +0900
@@ -526,5 +526,6 @@ DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= koelsch_init,
 	.init_late	= shmobile_init_late,
+	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= koelsch_boards_compat_dt,
 MACHINE_END
--- 0001/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-06-09 21:06:39.000000000 +0900
@@ -119,5 +119,6 @@ DT_MACHINE_START(LAGER_DT, "lager")
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= lager_add_standard_devices,
 	.init_late	= shmobile_init_late,
+	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= lager_boards_compat_dt,
 MACHINE_END
--- 0001/arch/arm/mach-shmobile/board-lager.c
+++ work/arch/arm/mach-shmobile/board-lager.c	2014-06-09 21:06:22.000000000 +0900
@@ -890,5 +890,6 @@ DT_MACHINE_START(LAGER_DT, "lager")
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= lager_init,
 	.init_late	= shmobile_init_late,
+	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= lager_boards_compat_dt,
 MACHINE_END
