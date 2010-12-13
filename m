From: "Szafranek, Michael" <Michael.Szafranek@emtrion.de>
Date: Mon, 13 Dec 2010 09:19:54 +0000
Subject: sh: sh7723/7724 nmi: nmi stops DMA transfers
Message-Id: <95F51F4B902CAC40AF459205F6322F0187A9C8F819@BMK019S01.emtrion.local>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

I've got a patch that fixes a problem when a NMI occurs which stops DMA transfers. The code in the patch resumes the DMA transfers. But it does not look like the proper place to solve this problem. If you could give me a hint were to move the code.

diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index 0830c2a..67f24bc 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -8,6 +8,8 @@
#include <linux/hardirq.h>
#include <asm/unwinder.h>
#include <asm/system.h>
+#include <asm/dma.h>
+#include <asm/dma-sh.h>

#ifdef CONFIG_GENERIC_BUG
static void handle_BUG(struct pt_regs *regs)
@@ -95,11 +97,13 @@ BUILD_TRAP_HANDLER(bug)

BUILD_TRAP_HANDLER(nmi)
{
+       unsigned long dmaor;
        unsigned int cpu = smp_processor_id();
        TRAP_HANDLER_DECL;

        nmi_enter();
        nmi_count(cpu)++;
+

        switch (notify_die(DIE_NMI, "NMI", regs, 0, vec & 0xff, SIGINT)) {
        case NOTIFY_OK:
@@ -111,6 +115,22 @@ BUILD_TRAP_HANDLER(nmi)
                printk(KERN_ALERT "Got NMI, but nobody cared. Ignoring...\n");
                break;
        }
-
+
+/* every NMI usually stops all active DMA transfers. These lines simply reanimate the */
+/* DMA channels so that the transfers are resumed                                     */
+#if defined(CONFIG_SH_HICO7723) || defined(CONFIG_SH_HICO7724)
+       dmaor = __raw_readw(SH_DMAC_BASE0 + DMAOR);
+       dmaor &= ~(DMAOR_NMIF | DMAOR_AE); // resetting NMI flag and address error flag
+       __raw_writew( dmaor, SH_DMAC_BASE0 + DMAOR );
+       dmaor |= DMAOR_INIT;               // restarting DMA
+       __raw_writew( dmaor, SH_DMAC_BASE0 + DMAOR );
+
+       dmaor = __raw_readw(SH_DMAC_BASE1 + DMAOR);
+       dmaor &= ~(DMAOR_NMIF | DMAOR_AE); // resetting NMI flag and address error flag
+       __raw_writew( dmaor, SH_DMAC_BASE1 + DMAOR );
+       dmaor |= DMAOR_INIT;               // restarting DMA
+       __raw_writew( dmaor, SH_DMAC_BASE1 + DMAOR );
+#endif
+
        nmi_exit();
}




_____________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch?ftsf?hrer: Dieter Baur, Ramona Maurer
_____________________________________

Important Note:
- This e-mail may contain trade secrets or privileged, undisclosed or otherwise confidential information.
- If you have received this e-mail in error, you are hereby notified that any review, copying or distribution of it is strictly prohibited.
- Please inform us immediately and destroy the original transmittal.

Thank you for your cooperation.
