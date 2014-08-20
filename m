From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Aug 2014 13:02:36 +0000
Subject: [PATCH 04/10] ARM: shmobile: sh7372: Use shmobile_init_delay()
Message-Id: <20140820130236.32075.74067.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the sh7372 SoC support code to use shmobile_init_delay()
together with CPU Frequency settings from the DTS. Get rid of the
C code version.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/setup-sh7372.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2014-08-20 21:01:39.000000000 +0900
@@ -984,7 +984,7 @@ void __init sh7372_add_early_devices(voi
 
 void __init sh7372_add_early_devices_dt(void)
 {
-	shmobile_setup_delay(800, 1, 3); /* Cortex-A8 @ 800MHz */
+	shmobile_init_delay();
 
 	sh7372_add_early_devices();
 }
