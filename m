From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 10 Jul 2015 06:37:13 +0000
Subject: [PATCH 8/8] ARM: shmobile: r8a7790: Make struct rcar_sysc_ch const
Message-Id: <bd82aff9192dad2bfd3cb3fc19fdf741c2f6028e.1436510166.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1436510166.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1436510166.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7790.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index 930f45cbc08a..2ef0054ce934 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -26,12 +26,12 @@
 #include "rcar-gen2.h"
 #include "r8a7790.h"
 
-static struct rcar_sysc_ch r8a7790_ca15_scu = {
+static const struct rcar_sysc_ch r8a7790_ca15_scu = {
 	.chan_offs = 0x180, /* PWRSR5 .. PWRER5 */
 	.isr_bit = 12, /* CA15-SCU */
 };
 
-static struct rcar_sysc_ch r8a7790_ca7_scu = {
+static const struct rcar_sysc_ch r8a7790_ca7_scu = {
 	.chan_offs = 0x100, /* PWRSR3 .. PWRER3 */
 	.isr_bit = 21, /* CA7-SCU */
 };
-- 
2.1.4

