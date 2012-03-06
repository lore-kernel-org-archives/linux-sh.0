From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Mar 2012 08:37:09 +0000
Subject: [PATCH 08/08] ARM: mach-shmobile: default to no earlytimer
Message-Id: <20120306083709.8131.2917.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Now when all SoCs and boards are converted to use
shmobile_earlytimer_init(), change the default behavior
of shmobile_timer.init() from using early timer to
do nothing which is suitable for upcoming DT support.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/timer.c |    1 -
 1 file changed, 1 deletion(-)

--- 0031/arch/arm/mach-shmobile/timer.c
+++ work/arch/arm/mach-shmobile/timer.c	2012-03-06 13:56:46.000000000 +0900
@@ -43,7 +43,6 @@ void __init shmobile_earlytimer_init(voi
 
 static void __init shmobile_timer_init(void)
 {
-	shmobile_earlytimer_init();
 }
 
 struct sys_timer shmobile_timer = {
