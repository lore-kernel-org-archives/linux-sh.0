From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 08 Nov 2010 04:07:47 +0000
Subject: [PATCH] ARM: mach-shmobile: intc-sh7372: fix interrupt number
Message-Id: <w3p1v6wwhv2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Tony SIM <chinyeow.sim.xt@renesas.com>

Signed-off-by: Tony SIM <chinyeow.sim.xt@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/intc-sh7372.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/intc-sh7372.c b/arch/arm/mach-shmobile/intc-sh7372.c
index e3551b5..8b0ffdd 100644
--- a/arch/arm/mach-shmobile/intc-sh7372.c
+++ b/arch/arm/mach-shmobile/intc-sh7372.c
@@ -98,7 +98,7 @@ static struct intc_vect intca_vectors[] __initdata = {
 	INTC_VECT(IRQ14A, 0x03c0), INTC_VECT(IRQ15A, 0x03e0),
 	INTC_VECT(IRQ16A, 0x3200), INTC_VECT(IRQ17A, 0x3220),
 	INTC_VECT(IRQ18A, 0x3240), INTC_VECT(IRQ19A, 0x3260),
-	INTC_VECT(IRQ20A, 0x3280), INTC_VECT(IRQ31A, 0x32a0),
+	INTC_VECT(IRQ20A, 0x3280), INTC_VECT(IRQ21A, 0x32a0),
 	INTC_VECT(IRQ22A, 0x32c0), INTC_VECT(IRQ23A, 0x32e0),
 	INTC_VECT(IRQ24A, 0x3300), INTC_VECT(IRQ25A, 0x3320),
 	INTC_VECT(IRQ26A, 0x3340), INTC_VECT(IRQ27A, 0x3360),
-- 
1.7.0.4

