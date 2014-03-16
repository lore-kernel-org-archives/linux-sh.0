From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 16 Mar 2014 21:36:14 +0000
Subject: [PATCH 06/06] ARM: shmobile: Install clocksource for r8a7790 tickless
Message-Id: <20140316213614.15598.11637.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Enable r8a7790 CMT clocksource to get tickless started.

Not-Yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7790.c |    1 +
 1 file changed, 1 insertion(+)

--- 0004/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -266,6 +266,7 @@ static const struct resource thermal_res
 static const struct sh_timer_config cmt00_platform_data __initconst = {
 	.name = "CMT00",
 	.timer_bit = 0,
+	.clocksource_rating = 100,
 	.clockevent_rating = 80,
 };
 
