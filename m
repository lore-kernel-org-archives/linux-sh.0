From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Aug 2014 13:03:30 +0000
Subject: [PATCH 10/10] ARM: shmobile: kzm9g: Use shmobile_init_delay()
Message-Id: <20140820130330.32075.37853.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the KZM9G board support code to use shmobile_init_delay()
together with CPU Frequency settings from the DTS.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/board-kzm9g-reference.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ work/arch/arm/mach-shmobile/board-kzm9g-reference.c	2014-08-20 21:14:41.000000000 +0900
@@ -51,7 +51,7 @@ static const char *kzm9g_boards_compat_d
 DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
-	.init_early	= sh73a0_init_delay,
+	.init_early	= shmobile_init_delay,
 	.init_machine	= kzm_init,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= kzm9g_boards_compat_dt,
