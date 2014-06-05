From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Jun 2014 06:47:54 +0000
Subject: [PATCH 03/03] ARM: shmobile: Use shmobile_init_delay() on r7s72100
Message-Id: <20140605064754.14469.8292.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20140224073006.3522.95891.sendpatchset@w520>
In-Reply-To: <20140224073006.3522.95891.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust Genmai board support to use shmobile_init_delay() together
with r7s72100 CPU Frequency settings from the DTS.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/board-genmai-reference.c |    2 +-
 arch/arm/mach-shmobile/board-genmai.c           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-genmai-reference.c
+++ work/arch/arm/mach-shmobile/board-genmai-reference.c	2014-05-29 17:50:54.000000000 +0900
@@ -47,7 +47,7 @@ static const char * const genmai_boards_
 };
 
 DT_MACHINE_START(GENMAI_DT, "genmai")
-	.init_early	= r7s72100_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_machine	= genmai_add_standard_devices,
 	.dt_compat	= genmai_boards_compat_dt,
 MACHINE_END
--- 0001/arch/arm/mach-shmobile/board-genmai.c
+++ work/arch/arm/mach-shmobile/board-genmai.c	2014-05-29 17:50:39.000000000 +0900
@@ -154,7 +154,7 @@ static const char * const genmai_boards_
 };
 
 DT_MACHINE_START(GENMAI_DT, "genmai")
-	.init_early	= r7s72100_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_machine	= genmai_add_standard_devices,
 	.dt_compat	= genmai_boards_compat_dt,
 MACHINE_END
