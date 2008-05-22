From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 May 2008 13:19:39 +0000
Subject: [PATCH] sh: fix VPU interrupt vector for sh7723
Message-Id: <20080522131939.12232.9743.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes a VPU vector typo for sh7723. The correct value is 0x980,
the same as for sh7722.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2008-05-22 14:20:33.000000000 +0900
@@ -153,7 +153,7 @@ static struct intc_vect vectors[] __init
 	INTC_VECT(VIO_VOUI,0x8E0),
 
 	INTC_VECT(SCIFA_SCIFA0,0x900),
-	INTC_VECT(VPU_VPUI,0x920),
+	INTC_VECT(VPU_VPUI,0x980),
 	INTC_VECT(TPU_TPUI,0x9A0),
 	INTC_VECT(ADC_ADI,0x9E0),
 	INTC_VECT(USB_USI0,0xA20),
