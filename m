From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 01 Oct 2013 02:37:09 +0000
Subject: [PATCH 09/12] ARM: shmobile: ape6evm: disable MMCIF Command Completion Signal
Message-Id: <a2eeabcceb3eb2646b0064b55b8ff0eb6f1ae13d.1380530519.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1380530519.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1380530519.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

MMCIF on r8a73a4 doesn't support Command Completion Signal, a platform
parameter has to be added to disable it on ape6evm.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 02be420..0365d2e 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -162,6 +162,7 @@ static struct regulator_consumer_supply vcc_sdhi1_consumers[]  /* MMCIF */
 static const struct sh_mmcif_plat_data mmcif0_pdata __initconst = {
 	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+	.ccs_unsupported = true,
 };
 
 static const struct resource mmcif0_resources[] __initconst = {
-- 
1.8.4

