From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Mar 2013 00:22:24 +0000
Subject: [PATCH 01/04] ARM: shmobile: Register DT TWD from timer.c
Message-Id: <20130306002224.5430.13116.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130306002214.5430.43766.sendpatchset@w520>
In-Reply-To: <20130306002214.5430.43766.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a call to twd_local_timer_of_register() in
the function shmobile_timer_init(). In case we
have TWD device information provided via DT this
will make sure the TWD driver gets registered.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/timer.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/mach-shmobile/timer.c
+++ work/arch/arm/mach-shmobile/timer.c	2013-03-05 17:55:48.000000000 +0900
@@ -65,4 +65,5 @@ void __init shmobile_timer_init(void)
 {
 	arch_timer_of_register();
 	arch_timer_sched_clock_init();
+	twd_local_timer_of_register();
 }
