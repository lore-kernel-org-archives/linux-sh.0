From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 29 Aug 2014 13:26:22 +0000
Subject: [PATCH 5/5] ARM: shmobile: r8a7740: Clean up pm domain table
Message-Id: <1409318782-28133-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

  - Sort pm domains by bit_shift value,
  - Combine closing and opening curly braces on a single line, as the
    table will grow much bigger soon.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-r8a7740.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 4d327de35d9b..b20dd5b37e6d 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -34,23 +34,21 @@ static int r8a7740_pd_a3sp_suspend(void)
 
 static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 	{
+		.genpd.name	= "A4LC",
+		.bit_shift	= 1,
+	}, {
 		.genpd.name	= "A4S",
 		.bit_shift	= 10,
 		.gov		= &pm_domain_always_on_gov,
 		.no_debug	= true,
 		.suspend	= r8a7740_pd_a4s_suspend,
-	},
-	{
+	}, {
 		.genpd.name	= "A3SP",
 		.bit_shift	= 11,
 		.gov		= &pm_domain_always_on_gov,
 		.no_debug	= true,
 		.suspend	= r8a7740_pd_a3sp_suspend,
 	},
-	{
-		.genpd.name	= "A4LC",
-		.bit_shift	= 1,
-	},
 };
 
 void __init r8a7740_init_pm_domains(void)
-- 
1.7.9.5

