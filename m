From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 30 Jul 2014 23:33:26 +0000
Subject: [PATCH 09/09] ARM: shmobile: Add shmobile_init_late() to r7s72100
Message-Id: <20140730233326.5969.46700.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend r7s72100 SoC machine vector to include shmobile_init_late()
so Suspend-to-RAM and CPUIdle are setup as expected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/setup-r7s72100.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/mach-shmobile/setup-r7s72100.c
+++ work/arch/arm/mach-shmobile/setup-r7s72100.c	2014-07-31 08:07:34.000000000 +0900
@@ -31,5 +31,6 @@ static const char *r7s72100_boards_compa
 
 DT_MACHINE_START(R7S72100_DT, "Generic R7S72100 (Flattened Device Tree)")
 	.init_early	= shmobile_init_delay,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= r7s72100_boards_compat_dt,
 MACHINE_END
