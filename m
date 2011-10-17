From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 17 Oct 2011 09:00:35 +0000
Subject: [PATCH] ARM: mach-shmobile: Add support for PINT though INTC macros
Message-Id: <20111017090035.21994.47228.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add a INTC_PINT() macro with various helper bits to allow SoCs
like sh73a0 to suppor the PINT hardware using regular INTC tables.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on "[PATCH 00/07] ARM: mach-shmobile: External IRQ pin update"

 arch/arm/mach-shmobile/include/mach/intc.h |   51 ++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

--- 0008/arch/arm/mach-shmobile/include/mach/intc.h
+++ work/arch/arm/mach-shmobile/include/mach/intc.h	2011-10-14 18:47:45.000000000 +0900
@@ -192,4 +192,55 @@ static struct intc_desc p ## _desc __ini
 			     p ## _sense_registers, p ## _ack_registers) \
 }
 
+#define INTC_PINT_E_EMPTY
+#define INTC_PINT_E_NONE 0, 0, 0, 0, 0, 0, 0, 0,
+#define INTC_PINT_E(p)							\
+	PINT ## p ## 0, PINT ## p ## 1, PINT ## p ## 2, PINT ## p ## 3,	\
+	PINT ## p ## 4, PINT ## p ## 5, PINT ## p ## 6, PINT ## p ## 7,
+
+#define INTC_PINT_V_NONE
+#define INTC_PINT_V(p, vect)					\
+	vect(PINT ## p ## 0, 0), vect(PINT ## p ## 1, 1),	\
+	vect(PINT ## p ## 2, 2), vect(PINT ## p ## 3, 3),	\
+	vect(PINT ## p ## 4, 4), vect(PINT ## p ## 5, 5),	\
+	vect(PINT ## p ## 6, 6), vect(PINT ## p ## 7, 7),
+
+#define INTC_PINT(p, mask_reg, sense_base, str,				\
+	enums_1, enums_2, enums_3, enums_4,				\
+	vect_1, vect_2, vect_3, vect_4,					\
+	mask_a, mask_b, mask_c, mask_d,					\
+	sense_a, sense_b, sense_c, sense_d)				\
+									\
+enum {									\
+	PINT ## p ## _UNUSED = 0,					\
+	enums_1 enums_2 enums_3 enums_4 				\
+};									\
+									\
+static struct intc_vect p ## _vectors[] __initdata = {			\
+	vect_1 vect_2 vect_3 vect_4					\
+};									\
+									\
+static struct intc_mask_reg p ## _mask_registers[] __initdata = {	\
+	{ mask_reg, 0, 32, /* PINTER */					\
+	  { mask_a mask_b mask_c mask_d } }				\
+};									\
+									\
+static struct intc_sense_reg p ## _sense_registers[] __initdata = {	\
+	{ sense_base + 0x00, 16, 2, /* PINTCR */			\
+	  { sense_a } },						\
+	{ sense_base + 0x04, 16, 2, /* PINTCR */			\
+	  { sense_b } },						\
+	{ sense_base + 0x08, 16, 2, /* PINTCR */			\
+	  { sense_c } },						\
+	{ sense_base + 0x0c, 16, 2, /* PINTCR */			\
+	  { sense_d } },						\
+};									\
+									\
+static struct intc_desc p ## _desc __initdata = {			\
+	.name = str,							\
+	.hw = INTC_HW_DESC(p ## _vectors, NULL,				\
+			     p ## _mask_registers, NULL,		\
+			     p ## _sense_registers, NULL),		\
+}
+
 #endif  /* __ASM_MACH_INTC_H */
