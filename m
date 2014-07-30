From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 30 Jul 2014 23:33:08 +0000
Subject: [PATCH 07/09] ARM: shmobile: Add shmobile_init_late() to r8a73a4
Message-Id: <20140730233308.5969.31790.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend r8a73a4 SoC machine vector to include shmobile_init_late()
so Suspend-to-RAM and CPUIdle are setup as expected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a73a4.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ work/arch/arm/mach-shmobile/setup-r8a73a4.c	2014-07-31 08:04:48.000000000 +0900
@@ -311,6 +311,7 @@ static const char *r8a73a4_boards_compat
 
 DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
 	.init_early	= r8a73a4_init_early,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a73a4_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
