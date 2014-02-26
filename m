From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 26 Feb 2014 07:57:51 +0000
Subject: [PATCH 5/7] ARM: shmobile: r8a7790 CA15-SCU enablement
Message-Id: <c2c97ec513b503b9e0d28ffd98d54c9e9bf3ea3e.1393400446.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1393400446.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1393400446.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>

Power on CA15 SCU in case of booting from a CA7 core.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
[damm@opensource.se: Converted to use broken out SYSC code]
Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7790.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index beb47ae..5910527 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -29,6 +29,11 @@
 #define CA7RESCNT	0x0044
 #define MERAM		0xe8080000
 
+static struct rcar_sysc_ch r8a7790_ca15_scu = {
+	.chan_offs = 0x180, /* PWRSR5 .. PWRER5 */
+	.isr_bit = 12, /* CA15-SCU */
+};
+
 static struct rcar_sysc_ch r8a7790_ca7_scu = {
 	.chan_offs = 0x100, /* PWRSR3 .. PWRER3 */
 	.isr_bit = 21, /* CA7-SCU */
@@ -64,6 +69,7 @@ static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
 
 	/* turn on power to SCU */
 	r8a7790_pm_init();
+	rcar_sysc_power_up(&r8a7790_ca15_scu);
 	rcar_sysc_power_up(&r8a7790_ca7_scu);
 }
 
-- 
1.8.5.2

