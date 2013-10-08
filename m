From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Oct 2013 05:58:42 +0000
Subject: [PATCH 4/7] ARM: shmobile: sh73a0: don't use named resource for TMU
Message-Id: <871u3wxq0h.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh_tmu driver doesn't care resource name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/setup-sh73a0.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 22de174..b7ce68e 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -273,7 +273,7 @@ static struct sh_timer_config tmu00_platform_data = {
 };
 
 static struct resource tmu00_resources[] = {
-	[0] = DEFINE_RES_MEM_NAMED(0xfff60008, 0xc, "TMU00"),
+	[0] = DEFINE_RES_MEM(0xfff60008, 0xc),
 	[1] = {
 		.start	= intcs_evt2irq(0x0e80), /* TMU0_TUNI00 */
 		.flags	= IORESOURCE_IRQ,
@@ -298,7 +298,7 @@ static struct sh_timer_config tmu01_platform_data = {
 };
 
 static struct resource tmu01_resources[] = {
-	[0] = DEFINE_RES_MEM_NAMED(0xfff60014, 0xc, "TMU00"),
+	[0] = DEFINE_RES_MEM(0xfff60014, 0xc),
 	[1] = {
 		.start	= intcs_evt2irq(0x0ea0), /* TMU0_TUNI01 */
 		.flags	= IORESOURCE_IRQ,
-- 
1.7.9.5

