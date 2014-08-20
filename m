From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Aug 2014 13:02:45 +0000
Subject: [PATCH 05/10] ARM: shmobile: sh73a0: Use shmobile_init_delay()
Message-Id: <20140820130245.32075.95808.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the sh73a0 SoC support code to use shmobile_init_delay()
together with CPU Frequency settings from the DTS. Get rid of the
C code version.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/setup-sh73a0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2014-08-20 21:16:16.000000000 +0900
@@ -746,7 +746,7 @@ void __init sh73a0_add_standard_devices(
 
 void __init sh73a0_init_delay(void)
 {
-	shmobile_setup_delay(1196, 44, 46); /* Cortex-A9 @ 1196MHz */
+	shmobile_init_delay();
 }
 
 /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
