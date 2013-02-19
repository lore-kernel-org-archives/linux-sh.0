From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 19 Feb 2013 02:47:40 +0000
Subject: [PATCH v2 6/8] ARM: shmobile: kzm9g: Do not use early devices
Message-Id: <1361242062-6957-7-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1361242062-6957-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1361242062-6957-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Do not initialise any early devices when using the minimal DT reference
code. Only the delay needs to be initialised.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index a4cd9e2..229e9e3 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -109,7 +109,7 @@ static const char *kzm9g_boards_compat_dt[] __initdata = {
 DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
-	.init_early	= sh73a0_add_early_devices_dt,
+	.init_early	= sh73a0_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= irqchip_init,
 	.init_machine	= kzm_init,
-- 
1.7.10.4

