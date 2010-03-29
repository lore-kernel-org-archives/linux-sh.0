From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 29 Mar 2010 06:31:46 +0000
Subject: [PATCH] ARM: mach-shmobile: Add missing __initdata on intcs
Message-Id: <u7hovvdt9.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/arm/mach-shmobile/intc-sh7367.c |    6 +++---
 arch/arm/mach-shmobile/intc-sh7377.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/intc-sh7367.c b/arch/arm/mach-shmobile/intc-sh7367.c
index 5ff70ca..b594969 100644
--- a/arch/arm/mach-shmobile/intc-sh7367.c
+++ b/arch/arm/mach-shmobile/intc-sh7367.c
@@ -75,7 +75,7 @@ enum {
 	ETM11, ARM11, USBHS, FLCTL, IIC1
 };
 
-static struct intc_vect intca_vectors[] = {
+static struct intc_vect intca_vectors[] __initdata = {
 	INTC_VECT(IRQ0A, 0x0200), INTC_VECT(IRQ1A, 0x0220),
 	INTC_VECT(IRQ2A, 0x0240), INTC_VECT(IRQ3A, 0x0260),
 	INTC_VECT(IRQ4A, 0x0280), INTC_VECT(IRQ5A, 0x02a0),
@@ -162,7 +162,7 @@ static struct intc_group intca_groups[] __initdata = {
 	INTC_GROUP(IIC1, IIC1_ALI1, IIC1_TACKI1, IIC1_WAITI1, IIC1_DTEI1),
 };
 
-static struct intc_mask_reg intca_mask_registers[] = {
+static struct intc_mask_reg intca_mask_registers[] __initdata = {
 	{ 0xe6900040, 0xe6900060, 8, /* INTMSK00A / INTMSKCLR00A */
 	  { IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A } },
 	{ 0xe6900044, 0xe6900064, 8, /* INTMSK10A / INTMSKCLR10A */
@@ -211,7 +211,7 @@ static struct intc_mask_reg intca_mask_registers[] = {
 	    MISTY, CMT3, RWDT1, RWDT0 } },
 };
 
-static struct intc_prio_reg intca_prio_registers[] = {
+static struct intc_prio_reg intca_prio_registers[] __initdata = {
 	{ 0xe6900010, 0, 32, 4, /* INTPRI00A */
 	  { IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A } },
 	{ 0xe6900014, 0, 32, 4, /* INTPRI10A */
diff --git a/arch/arm/mach-shmobile/intc-sh7377.c b/arch/arm/mach-shmobile/intc-sh7377.c
index 5c781e2..68901a4 100644
--- a/arch/arm/mach-shmobile/intc-sh7377.c
+++ b/arch/arm/mach-shmobile/intc-sh7377.c
@@ -90,7 +90,7 @@ enum {
 	ICUSB, ICUDMC
 };
 
-static struct intc_vect intca_vectors[] = {
+static struct intc_vect intca_vectors[] __initdata = {
 	INTC_VECT(IRQ0A, 0x0200), INTC_VECT(IRQ1A, 0x0220),
 	INTC_VECT(IRQ2A, 0x0240), INTC_VECT(IRQ3A, 0x0260),
 	INTC_VECT(IRQ4A, 0x0280), INTC_VECT(IRQ5A, 0x02a0),
@@ -202,7 +202,7 @@ static struct intc_group intca_groups[] __initdata = {
 	INTC_GROUP(ICUDMC, ICUDMC_ICUDMC1, ICUDMC_ICUDMC2),
 };
 
-static struct intc_mask_reg intca_mask_registers[] = {
+static struct intc_mask_reg intca_mask_registers[] __initdata = {
 	{ 0xe6900040, 0xe6900060, 8, /* INTMSK00A / INTMSKCLR00A */
 	  { IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A } },
 	{ 0xe6900044, 0xe6900064, 8, /* INTMSK10A / INTMSKCLR10A */
@@ -272,7 +272,7 @@ static struct intc_mask_reg intca_mask_registers[] = {
 	    SCIFA6, 0, 0, 0 } },
 };
 
-static struct intc_prio_reg intca_prio_registers[] = {
+static struct intc_prio_reg intca_prio_registers[] __initdata = {
 	{ 0xe6900010, 0, 32, 4, /* INTPRI00A */
 	  { IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A } },
 	{ 0xe6900014, 0, 32, 4, /* INTPRI10A */
-- 
1.6.3.3

