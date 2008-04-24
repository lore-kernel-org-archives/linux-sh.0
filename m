From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 24 Apr 2008 12:41:12 +0000
Subject: [PATCH] sh: clean up sh7710 and sh7720 intc tables
Message-Id: <20080424124112.19661.10169.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Clean up the intc tables by removing unneeded #ifdefs. The vector
list is what selects which interrupt sources that should be added,
having unsupported bitfields listed is ok as long as the vector
is excluded from the list.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh3/setup-sh7710.c |    5 +----
 arch/sh/kernel/cpu/sh3/setup-sh7720.c |    4 ----
 2 files changed, 1 insertion(+), 8 deletions(-)

--- 0010/arch/sh/kernel/cpu/sh3/setup-sh7710.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7710.c	2008-04-24 20:26:48.000000000 +0900
@@ -79,10 +79,7 @@ static struct intc_prio_reg prio_registe
 	{ 0xa4000016, 0, 16, 4, /* IPRC */ { IRQ3, IRQ2, IRQ1, IRQ0 } },
 	{ 0xa4000018, 0, 16, 4, /* IPRD */ { 0, 0, IRQ5, IRQ4 } },
 	{ 0xa400001a, 0, 16, 4, /* IPRE */ { DMAC1, SCIF0, SCIF1 } },
-	{ 0xa4080000, 0, 16, 4, /* IPRF */ { 0, DMAC2 } },
-#ifdef CONFIG_CPU_SUBTYPE_SH7710
-	{ 0xa4080000, 0, 16, 4, /* IPRF */ { IPSEC } },
-#endif
+	{ 0xa4080000, 0, 16, 4, /* IPRF */ { IPSEC, DMAC2 } },
 	{ 0xa4080002, 0, 16, 4, /* IPRG */ { EDMAC0, EDMAC1, EDMAC2 } },
 	{ 0xa4080004, 0, 16, 4, /* IPRH */ { 0, 0, 0, SIOF0 } },
 	{ 0xa4080006, 0, 16, 4, /* IPRI */ { 0, 0, SIOF1 } },
--- 0010/arch/sh/kernel/cpu/sh3/setup-sh7720.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7720.c	2008-04-24 20:26:14.000000000 +0900
@@ -211,11 +211,7 @@ static struct intc_prio_reg prio_registe
 	{ 0xA414FEE4UL, 0, 16, 4, /* IPRB */ { WDT, REF_RCMI, SIM, 0 } },
 	{ 0xA4140016UL, 0, 16, 4, /* IPRC */ { IRQ3, IRQ2, IRQ1, IRQ0 } },
 	{ 0xA4140018UL, 0, 16, 4, /* IPRD */ { USBF_SPD, TMU_SUNI, IRQ5, IRQ4 } },
-#if defined(CONFIG_CPU_SUBTYPE_SH7720)
 	{ 0xA414001AUL, 0, 16, 4, /* IPRE */ { DMAC1, 0, LCDC, SSL } },
-#else
-	{ 0xA414001AUL, 0, 16, 4, /* IPRE */ { DMAC1, 0, LCDC, 0 } },
-#endif
 	{ 0xA4080000UL, 0, 16, 4, /* IPRF */ { ADC, DMAC2, USBFI, CMT } },
 	{ 0xA4080002UL, 0, 16, 4, /* IPRG */ { SCIF0, SCIF1, 0, 0 } },
 	{ 0xA4080004UL, 0, 16, 4, /* IPRH */ { PINT07, PINT815, TPU, IIC } },
