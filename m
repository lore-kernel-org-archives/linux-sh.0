From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 31 Jul 2013 19:03:00 +0000
Subject: [PATCH 12/13] ARM: shmobile: Use clocksource_of_init() on r8a7790
Message-Id: <20130731190300.31796.23926.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130731190110.31796.96552.sendpatchset@w520>
In-Reply-To: <20130731190110.31796.96552.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Replace the call to shmobile_timer_init() with
clocksource_of_init(). This will allow us to
get rid of shmobile_timer_init().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7790.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-08-01 03:17:48.000000000 +0900
@@ -263,7 +263,7 @@ void __init r8a7790_timer_init(void)
 	iounmap(base);
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
-	shmobile_timer_init();
+	clocksource_of_init();
 }
 
 void __init r8a7790_init_delay(void)
