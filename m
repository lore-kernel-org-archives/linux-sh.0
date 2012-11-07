From: Simon Horman <horms@verge.net.au>
Date: Wed, 07 Nov 2012 08:50:40 +0000
Subject: [PATCH 11/15] ARM: shmobile: kzm9g: Use DT initialisation of INTC
Message-Id: <1352278244-26702-12-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1352278244-26702-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1352278244-26702-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 0a43f31..0a0f302 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -779,7 +779,7 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g")
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_add_early_devices,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= sh73a0_init_irq,
+	.init_irq	= sh73a0_init_irq_of,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= kzm_init,
 	.init_late	= shmobile_init_late,
-- 
1.7.10.4

