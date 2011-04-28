From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 Apr 2011 02:55:59 +0000
Subject: [PATCH] ARM: mach-shmobile: Use SCIFA and SCIFB port types on sh7377
Message-Id: <20110428030240.19870.42931.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the sh7377 serial port types to make use of 
PORT_SCIFA and PORT_SCIFB. This makes the software
match the sh7377 data sheet.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-sh7377.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- 0004/arch/arm/mach-shmobile/setup-sh7377.c
+++ work/arch/arm/mach-shmobile/setup-sh7377.c	2011-04-27 21:46:36.000000000 +0900
@@ -39,7 +39,7 @@ static struct plat_sci_port scif0_platfo
 	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0xc00), evt2irq(0xc00),
 			    evt2irq(0xc00), evt2irq(0xc00) },
 };
@@ -58,7 +58,7 @@ static struct plat_sci_port scif1_platfo
 	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0xc20), evt2irq(0xc20),
 			    evt2irq(0xc20), evt2irq(0xc20) },
 };
@@ -77,7 +77,7 @@ static struct plat_sci_port scif2_platfo
 	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0xc40), evt2irq(0xc40),
 			    evt2irq(0xc40), evt2irq(0xc40) },
 };
@@ -96,7 +96,7 @@ static struct plat_sci_port scif3_platfo
 	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0xc60), evt2irq(0xc60),
 			    evt2irq(0xc60), evt2irq(0xc60) },
 };
@@ -115,7 +115,7 @@ static struct plat_sci_port scif4_platfo
 	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0xd20), evt2irq(0xd20),
 			    evt2irq(0xd20), evt2irq(0xd20) },
 };
@@ -134,7 +134,7 @@ static struct plat_sci_port scif5_platfo
 	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0xd40), evt2irq(0xd40),
 			    evt2irq(0xd40), evt2irq(0xd40) },
 };
@@ -153,7 +153,7 @@ static struct plat_sci_port scif6_platfo
 	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFA,
 	.irqs		= { intcs_evt2irq(0x1a80), intcs_evt2irq(0x1a80),
 			    intcs_evt2irq(0x1a80), intcs_evt2irq(0x1a80) },
 };
@@ -172,7 +172,7 @@ static struct plat_sci_port scif7_platfo
 	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_RE | SCSCR_TE,
 	.scbrr_algo_id	= SCBRR_ALGO_4,
-	.type		= PORT_SCIF,
+	.type		= PORT_SCIFB,
 	.irqs		= { evt2irq(0xd60), evt2irq(0xd60),
 			    evt2irq(0xd60), evt2irq(0xd60) },
 };
