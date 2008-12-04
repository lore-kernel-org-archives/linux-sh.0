From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Dec 2008 09:00:02 +0000
Subject: [PATCH 02/06] sh: fix number of interrupts on se7343
Message-Id: <20081204090002.25773.47795.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Fix to make sure that the on-board interrupt sources are included
in the interrupt count on se7343.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-se/7343/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/boards/mach-se/7343/setup.c
+++ work/arch/sh/boards/mach-se/7343/setup.c	2008-12-04 13:41:45.000000000 +0900
@@ -126,7 +126,7 @@ static void __init sh7343se_setup(char *
 static struct sh_machine_vector mv_7343se __initmv = {
 	.mv_name = "SolutionEngine 7343",
 	.mv_setup = sh7343se_setup,
-	.mv_nr_irqs = 108,
+	.mv_nr_irqs = SE7343_FPGA_IRQ_BASE + SE7343_FPGA_IRQ_NR,
 	.mv_inb = sh7343se_inb,
 	.mv_inw = sh7343se_inw,
 	.mv_inl = sh7343se_inl,
