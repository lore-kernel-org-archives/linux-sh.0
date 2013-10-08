From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Oct 2013 05:59:23 +0000
Subject: [PATCH 7/7] ARM: shmobile: r8a73a4: don't use named irq for DMAEngine
Message-Id: <87wqlowbf1.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh-dma-engine driver doesn't care irq name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/setup-r8a73a4.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index b0f2749..cc94b64 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -275,7 +275,7 @@ static const struct sh_dmae_pdata dma_pdata = {
 
 static struct resource dma_resources[] = {
 	DEFINE_RES_MEM(0xe6700020, 0x89e0),
-	DEFINE_RES_IRQ_NAMED(gic_spi(220), "error_irq"),
+	DEFINE_RES_IRQ(gic_spi(220)),
 	{
 		/* IRQ for channels 0-19 */
 		.start  = gic_spi(200),
-- 
1.7.9.5

