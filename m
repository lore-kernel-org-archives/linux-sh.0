From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 02 Aug 2013 01:33:48 +0000
Subject: [PATCH 2/4] ARM: shmobile: r8a7790: add missing __initdata
Message-Id: <87txj898qu.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds missing __initdata to driver data/resource
which are used from platform_device_register_xxx()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/setup-r8a7790.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 86cf507..ea2f00b 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -160,13 +160,13 @@ static struct resource thermal_resources[] __initdata = {
 					thermal_resources,		\
 					ARRAY_SIZE(thermal_resources))
 
-static struct sh_timer_config cmt00_platform_data = {
+static struct sh_timer_config cmt00_platform_data __initdata = {
 	.name = "CMT00",
 	.timer_bit = 0,
 	.clockevent_rating = 80,
 };
 
-static struct resource cmt00_resources[] = {
+static struct resource cmt00_resources[] __initdata = {
 	DEFINE_RES_MEM(0xffca0510, 0x0c),
 	DEFINE_RES_MEM(0xffca0500, 0x04),
 	DEFINE_RES_IRQ(gic_spi(142)), /* CMT0_0 */
-- 
1.7.9.5

