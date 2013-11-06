From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Nov 2013 23:21:20 +0000
Subject: [PATCH 02/04] ARM: shmobile: Use ->init_late() in shared EMEV2 case
Message-Id: <20131106232120.8081.76012.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20131106232102.8081.20523.sendpatchset@w520>
In-Reply-To: <20131106232102.8081.20523.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Hook up shmobile_init_late() to enable various
code such as suspend-to-RAM and CPUIdle.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-emev2.c |    1 +
 1 file changed, 1 insertion(+)

--- 0004/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-11-05 15:58:30.000000000 +0900
@@ -79,6 +79,7 @@ DT_MACHINE_START(EMEV2_DT, "Generic Emma
 	.map_io		= emev2_map_io,
 	.init_early	= emev2_init_delay,
 	.init_machine	= emev2_add_standard_devices_dt,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= emev2_boards_compat_dt,
 MACHINE_END
 
