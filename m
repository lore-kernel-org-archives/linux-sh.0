From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 30 Sep 2015 15:50:18 +0000
Subject: [PATCH 1/3] ARM: shmobile: smp: Make shmobile_smp_apmu_cpu_shutdown() static
Message-Id: <1443628220-1352-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1443628220-1352-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1443628220-1352-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

shmobile_smp_apmu_cpu_shutdown() is used inside platsmp-apmu.c only.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 4e54512bee308312..bcf4cc51b926c479 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -170,7 +170,7 @@ static inline void cpu_enter_lowpower_a15(void)
 	dsb();
 }
 
-void shmobile_smp_apmu_cpu_shutdown(unsigned int cpu)
+static void shmobile_smp_apmu_cpu_shutdown(unsigned int cpu)
 {
 
 	/* Select next sleep mode using the APMU */
-- 
1.9.1

