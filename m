From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 30 Jul 2014 23:33:17 +0000
Subject: [PATCH 08/09] ARM: shmobile: Add shmobile_init_late() to APE6EVM
Message-Id: <20140730233317.5969.91454.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend board specific APE6EVM reference machine vectors to include
shmobile_init_late() so Suspend-to-RAM and CPUIdle are setup as expected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/board-ape6evm-reference.c |    1 +
 arch/arm/mach-shmobile/board-ape6evm.c           |    1 +
 2 files changed, 2 insertions(+)

--- 0001/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ work/arch/arm/mach-shmobile/board-ape6evm-reference.c	2014-07-31 07:59:04.000000000 +0900
@@ -61,5 +61,6 @@ static const char *ape6evm_boards_compat
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
 	.init_early	= r8a73a4_init_early,
 	.init_machine	= ape6evm_add_standard_devices,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= ape6evm_boards_compat_dt,
 MACHINE_END
--- 0001/arch/arm/mach-shmobile/board-ape6evm.c
+++ work/arch/arm/mach-shmobile/board-ape6evm.c	2014-07-31 08:01:40.000000000 +0900
@@ -285,5 +285,6 @@ static const char *ape6evm_boards_compat
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
 	.init_early	= r8a73a4_init_early,
 	.init_machine	= ape6evm_add_standard_devices,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= ape6evm_boards_compat_dt,
 MACHINE_END
