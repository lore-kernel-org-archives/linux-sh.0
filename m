From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Aug 2014 13:03:21 +0000
Subject: [PATCH 09/10] ARM: shmobile: bockw: Use shmobile_init_delay()
Message-Id: <20140820130321.32075.36530.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the BockW board support code to use shmobile_init_delay()
together with CPU Frequency settings from the DTS.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/board-bockw-reference.c |    2 +-
 arch/arm/mach-shmobile/board-bockw.c           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-bockw-reference.c
+++ work/arch/arm/mach-shmobile/board-bockw-reference.c	2014-08-20 21:06:29.000000000 +0900
@@ -80,7 +80,7 @@ static const char *bockw_boards_compat_d
 };
 
 DT_MACHINE_START(BOCKW_DT, "bockw")
-	.init_early	= r8a7778_init_delay,
+	.init_early	= shmobile_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
 	.init_machine	= bockw_init,
 	.init_late	= shmobile_init_late,
--- 0001/arch/arm/mach-shmobile/board-bockw.c
+++ work/arch/arm/mach-shmobile/board-bockw.c	2014-08-20 21:06:18.000000000 +0900
@@ -733,7 +733,7 @@ static const char *bockw_boards_compat_d
 };
 
 DT_MACHINE_START(BOCKW_DT, "bockw")
-	.init_early	= r8a7778_init_delay,
+	.init_early	= shmobile_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
 	.init_machine	= bockw_init,
 	.dt_compat	= bockw_boards_compat_dt,
