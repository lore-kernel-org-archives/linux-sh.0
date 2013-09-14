From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 14 Sep 2013 13:46:52 +0000
Subject: [PATCH 04/05] ARM: shmobile: Let r8a7779 rely on SCU CPU notifier
Message-Id: <20130914134652.19258.20535.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130914134616.19258.27110.sendpatchset@w520>
In-Reply-To: <20130914134616.19258.27110.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Now when CPU notifiers are used for SCU boot vector
setup shmobile_smp_scu_boot_secondary() is no longer
needed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-r8a7779.c |    4 ----
 1 file changed, 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/smp-r8a7779.c
+++ work/arch/arm/mach-shmobile/smp-r8a7779.c	2013-09-14 19:36:57.000000000 +0900
@@ -87,10 +87,6 @@ static int r8a7779_boot_secondary(unsign
 	unsigned int lcpu = cpu_logical_map(cpu);
 	int ret;
 
-	ret = shmobile_smp_scu_boot_secondary(cpu, idle);
-	if (ret)
-		return ret;
-
 	if (lcpu < ARRAY_SIZE(r8a7779_ch_cpu))
 		ch = r8a7779_ch_cpu[lcpu];
 
