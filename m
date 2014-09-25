From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 25 Sep 2014 16:15:36 +0000
Subject: [PATCH v2 05/11] ARM: shmobile: r8a7740: Add A3RV pm domain support
Message-Id: <1411661742-4767-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1411661742-4767-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1411661742-4767-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add support for the A3RV power domain.
This domain contains the VPU5F and VCP1 hardware blocks, which are
currently not used by any driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes

 arch/arm/mach-shmobile/pm-r8a7740.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index e3f1464482371bb4..1d916038660d4b8a 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -37,6 +37,9 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 		.genpd.name	= "A4LC",
 		.bit_shift	= 1,
 	}, {
+		.genpd.name	= "A3RV",
+		.bit_shift	= 6,
+	}, {
 		.genpd.name	= "A4S",
 		.bit_shift	= 10,
 		.gov		= &pm_domain_always_on_gov,
-- 
1.9.1

