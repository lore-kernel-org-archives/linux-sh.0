From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 18 Jan 2011 03:13:44 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 INTCS MFIS2 interrupt update
Message-Id: <20110118031344.11918.19161.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20100311054221.27152.9839.sendpatchset@t400s>
In-Reply-To: <20100311054221.27152.9839.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Enable the MFIS2 interrupt source in the INTCS interrupt
controller included in the sh7372 processor. The priority
field is constantly enabled to let the interrupt through to
both the ARM side and the SH side.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/intc-sh7372.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/intc-sh7372.c
+++ work/arch/arm/mach-shmobile/intc-sh7372.c	2011-01-17 12:41:30.000000000 +0900
@@ -365,6 +365,7 @@ static struct intc_desc intca_desc __ini
 
 enum {
 	UNUSED_INTCS = 0,
+	ENABLED_INTCS,
 
 	INTCS,
 
@@ -413,7 +414,7 @@ enum {
 	CMT4,
 	DSITX1_DSITX1_0,
 	DSITX1_DSITX1_1,
-	/* MFIS2 */
+	MFIS2_INTCS, /* Priority always enabled using ENABLED_INTCS */
 	CPORTS2R,
 	/* CEC */
 	JPU6E,
@@ -477,7 +478,7 @@ static struct intc_vect intcs_vectors[] 
 	INTCS_VECT(CMT4, 0x1980),
 	INTCS_VECT(DSITX1_DSITX1_0, 0x19a0),
 	INTCS_VECT(DSITX1_DSITX1_1, 0x19c0),
-	/* MFIS2 */
+	INTCS_VECT(MFIS2_INTCS, 0x1a00),
 	INTCS_VECT(CPORTS2R, 0x1a20),
 	/* CEC */
 	INTCS_VECT(JPU6E, 0x1a80),
@@ -543,7 +544,7 @@ static struct intc_mask_reg intcs_mask_r
 	  { 0, TMU1_TUNI2, TMU1_TUNI1, TMU1_TUNI0,
 	    CMT4, DSITX1_DSITX1_0, DSITX1_DSITX1_1, 0 } },
 	{ 0xffd5019c, 0xffd501dc, 8, /* IMR7SA3 / IMCR7SA3 */
-	  { 0, CPORTS2R, 0, 0,
+	  { MFIS2_INTCS, CPORTS2R, 0, 0,
 	    JPU6E, 0, 0, 0 } },
 	{ 0xffd20104, 0, 16, /* INTAMASK */
 	  { 0, 0, 0, 0, 0, 0, 0, 0,
@@ -571,7 +572,8 @@ static struct intc_prio_reg intcs_prio_r
 	{ 0xffd50030, 0, 16, 4, /* IPRMS3 */ { TMU1, 0, 0, 0 } },
 	{ 0xffd50034, 0, 16, 4, /* IPRNS3 */ { CMT4, DSITX1_DSITX1_0,
 					       DSITX1_DSITX1_1, 0 } },
-	{ 0xffd50038, 0, 16, 4, /* IPROS3 */ { 0, CPORTS2R, 0, 0 } },
+	{ 0xffd50038, 0, 16, 4, /* IPROS3 */ { ENABLED_INTCS, CPORTS2R,
+					       0, 0 } },
 	{ 0xffd5003c, 0, 16, 4, /* IPRPS3 */ { JPU6E, 0, 0, 0 } },
 };
 
@@ -590,6 +592,7 @@ static struct resource intcs_resources[]
 
 static struct intc_desc intcs_desc __initdata = {
 	.name = "sh7372-intcs",
+	.force_enable = ENABLED_INTCS,
 	.resource = intcs_resources,
 	.num_resources = ARRAY_SIZE(intcs_resources),
 	.hw = INTC_HW_DESC(intcs_vectors, intcs_groups, intcs_mask_registers,
