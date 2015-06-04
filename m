From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 04 Jun 2015 18:22:35 +0000
Subject: [PATCH 11/11] ARM: shmobile: r8a7790: Make struct rcar_sysc_ch const
Message-Id: <1433442155-19492-12-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/smp-r8a7790.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index 930f45cbc08a5bb3..2ef0054ce934f021 100644
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
1.9.1

