From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 17 Jul 2013 23:31:59 +0000
Subject: [PATCH 20/22] ARM: shmobile: Fix EMEV2 clock comment typo
Message-Id: <09cb2e366737ac70f1d7c6c0a3747a75c8f90f1e.1374103272.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1374103272.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1374103272.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the STI timer frequency comment to 32.768 kHz to
fix 37 kHz typo.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-emev2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-emev2.c b/arch/arm/mach-shmobile/clock-emev2.c
index 4710f18..56dd0cf 100644
--- a/arch/arm/mach-shmobile/clock-emev2.c
+++ b/arch/arm/mach-shmobile/clock-emev2.c
@@ -221,7 +221,7 @@ void __init emev2_clock_init(void)
 	smu_base = ioremap(EMEV2_SMU_BASE, PAGE_SIZE);
 	BUG_ON(!smu_base);
 
-	/* setup STI timer to run on 37.768 kHz and deassert reset */
+	/* setup STI timer to run on 32.768 kHz and deassert reset */
 	emev2_smu_write(0, STI_CLKSEL);
 	emev2_smu_write(1, STI_RSTCTRL);
 
-- 
1.7.10.4

