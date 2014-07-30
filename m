From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 30 Jul 2014 23:45:00 +0000
Subject: [PATCH] ARM: shmobile: Use shmobile_init_delay() on APE6EVM
Message-Id: <20140730234500.18995.49199.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20140511231050.19908.86623.sendpatchset@w520>
In-Reply-To: <20140511231050.19908.86623.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

The r8a73a4 DTS includes CPU Frequency information so
adjust the APE6EVM board code to use shmobile_init_delay()
instead of relying on CPU Frequency information included
in r8a73a4_init_delay() that is specified in C.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-v3.16-rc7-20140729 and
 [PATCH 00/09] ARM: shmobile: Consistent use of shmobile_init_late()

 arch/arm/mach-shmobile/board-ape6evm-reference.c |    2 +-
 arch/arm/mach-shmobile/board-ape6evm.c           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- 0002/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ work/arch/arm/mach-shmobile/board-ape6evm-reference.c	2014-07-31 08:38:10.000000000 +0900
@@ -59,7 +59,7 @@ static const char *ape6evm_boards_compat
 };
 
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
-	.init_early	= r8a73a4_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_machine	= ape6evm_add_standard_devices,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= ape6evm_boards_compat_dt,
--- 0002/arch/arm/mach-shmobile/board-ape6evm.c
+++ work/arch/arm/mach-shmobile/board-ape6evm.c	2014-07-31 08:39:22.000000000 +0900
@@ -283,7 +283,7 @@ static const char *ape6evm_boards_compat
 };
 
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
-	.init_early	= r8a73a4_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_machine	= ape6evm_add_standard_devices,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= ape6evm_boards_compat_dt,
