From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 13 Jun 2013 06:59:47 +0000
Subject: [PATCH 09/15] ARM: shmobile: EMEV2 SMP with SCU boot fn and args
Message-Id: <1371106793-25071-10-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Let EMEV2 make use of shmobile_boot_fn and shmobile_boot_arg
together with shmobile_boot_scu and the SCU base address.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-emev2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
index e38691b..80991b3 100644
--- a/arch/arm/mach-shmobile/smp-emev2.c
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -40,8 +40,10 @@ static void __init emev2_smp_prepare_cpus(unsigned int max_cpus)
 {
 	scu_enable(shmobile_scu_base);
 
-	/* Tell ROM loader about our vector (in headsmp-scu.S) */
-	emev2_set_boot_vector(__pa(shmobile_secondary_vector_scu));
+	/* Tell ROM loader about our vector (in headsmp-scu.S, headsmp.S) */
+	emev2_set_boot_vector(__pa(shmobile_boot_vector));
+	shmobile_boot_fn = virt_to_phys(shmobile_boot_scu);
+	shmobile_boot_arg = (unsigned long)shmobile_scu_base;
 
 	/* enable cache coherency on booting CPU */
 	scu_power_mode(shmobile_scu_base, SCU_PM_NORMAL);
-- 
1.8.2.1

