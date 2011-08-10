From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Aug 2011 05:45:30 +0000
Subject: [PATCH] ARM: mach-shmobile: Remove 3DG/SGX from sh7372 INTCS
Message-Id: <20110810054530.7131.56511.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch removes support for the SGX interrupt source in
the sh7372 INTCS controller.

The SGX hardware block included in sh7372 is already hooked
up to the ARM Cortex-A8 core using the INTCA controller,
so SGX users are encouraged to make use of that interrupt
source instead.

Removing support for the SGX interrupt source in INTCS 
simplifies the sh7372 power management code by allowing
us to assume that only INTCA needs to be powered on to
operate the SGX hardware.

If the INTCS interrupt source would be kept then the kernel
would be forced to deal with additional dependencies that does
not follow the regular power domain hiearachy. With this
patch in place we can safely power down INTCS while the
SGX is operating.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/intc-sh7372.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/intc-sh7372.c
+++ work/arch/arm/mach-shmobile/intc-sh7372.c	2011-08-10 13:01:41.000000000 +0900
@@ -379,7 +379,7 @@ enum {
 	/* BBIF2 */
 	VPU,
 	TSIF1,
-	_3DG_SGX530,
+	/* 3DG */
 	_2DDMAC,
 	IIC2_ALI2, IIC2_TACKI2, IIC2_WAITI2, IIC2_DTEI2,
 	IPMMU_IPMMUR, IPMMU_IPMMUR2,
@@ -436,7 +436,7 @@ static struct intc_vect intcs_vectors[]
 	/* BBIF2 */
 	INTCS_VECT(VPU, 0x980),
 	INTCS_VECT(TSIF1, 0x9a0),
-	INTCS_VECT(_3DG_SGX530, 0x9e0),
+	/* 3DG */
 	INTCS_VECT(_2DDMAC, 0xa00),
 	INTCS_VECT(IIC2_ALI2, 0xa80), INTCS_VECT(IIC2_TACKI2, 0xaa0),
 	INTCS_VECT(IIC2_WAITI2, 0xac0), INTCS_VECT(IIC2_DTEI2, 0xae0),
@@ -521,7 +521,7 @@ static struct intc_mask_reg intcs_mask_r
 	    RTDMAC_1_DEI3, RTDMAC_1_DEI2, RTDMAC_1_DEI1, RTDMAC_1_DEI0 } },
 	{ 0xffd20198, 0xffd201d8, 8, /* IMR6SA / IMCR6SA */
 	  { 0, 0, MSIOF, 0,
-	    _3DG_SGX530, 0, 0, 0 } },
+	    0, 0, 0, 0 } },
 	{ 0xffd2019c, 0xffd201dc, 8, /* IMR7SA / IMCR7SA */
 	  { 0, TMU_TUNI2, TMU_TUNI1, TMU_TUNI0,
 	    0, 0, 0, 0 } },
@@ -561,7 +561,6 @@ static struct intc_prio_reg intcs_prio_r
 					      TMU_TUNI2, TSIF1 } },
 	{ 0xffd2001c, 0, 16, 4, /* IPRHS */ { 0, 0, VEU, BEU } },
 	{ 0xffd20020, 0, 16, 4, /* IPRIS */ { 0, MSIOF, TSIF0, IIC0 } },
-	{ 0xffd20024, 0, 16, 4, /* IPRJS */ { 0, _3DG_SGX530, 0, 0 } },
 	{ 0xffd20028, 0, 16, 4, /* IPRKS */ { 0, 0, LMB, 0 } },
 	{ 0xffd2002c, 0, 16, 4, /* IPRLS */ { IPMMU, 0, 0, 0 } },
 	{ 0xffd20030, 0, 16, 4, /* IPRMS */ { IIC2, 0, 0, 0 } },
