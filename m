From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Tue, 10 Mar 2009 13:24:30 +0000
Subject: [Proposal][PATCH] sh: Suspend in Ram on sh4
Message-Id: <49B66A0E.1020400@st.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000306040007000300060604"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------000306040007000300060604
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi all
I would propose an other version of suspend in ram.

In ST we have several constraints:
- Several SOCs with different Clock IPs
- No cache memory mapped (it was removed in recently version of ST40)
- No IPREF instruction..
- 29/32 bits supports (where in 32 bits we are managing the PMB in a 
different manner respect the original kernel.org code).

For these reason an hard-coded suspend assembly code isn't easy to use 
for us.

To address the issue we are using a mini interpreter able to execute 
macro instructions SOC based.
The assembly code preloads (with a jump sequence) in cache (both I$ and 
D$) the 'instruction-table'
and after that it executes the instruction-table.

This solution allow me to have no assembly code SOCs specific and
for each SOC I have only to produce the right "tables" for standby 
and/or mem-standby.

Moreover a 3rd table is supported to be able to produce or save data on 
the fly for the standby it-self (for example if we have different action 
on the same SOC but different Cut).

Let me know.
Regards
Francesco

P.S.: in attach an example on how I'm using the suspend core code.

--------------000306040007000300060604
Content-Type: text/x-patch;
 name="0001-Suspend-in-Ram-support-on-Sh4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Suspend-in-Ram-support-on-Sh4.patch"

From dc7e67600f58bf04eae348c43854c1757f052f19 Mon Sep 17 00:00:00 2001
From: Francesco Virlinzi <francesco.virlinzi@st.com>
Date: Mon, 9 Mar 2009 16:05:18 +0100
Subject: [PATCH] Suspend in Ram support on Sh4


Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/Kconfig                       |    1 +
 arch/sh/include/cpu-sh4/suspend.h     |  260 ++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4/Makefile       |    4 +
 arch/sh/kernel/cpu/sh4/suspend-core.S |  350 +++++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4/suspend.c      |  113 +++++++++++
 5 files changed, 728 insertions(+), 0 deletions(-)
 create mode 100644 arch/sh/include/cpu-sh4/suspend.h
 create mode 100644 arch/sh/kernel/cpu/sh4/suspend-core.S
 create mode 100644 arch/sh/kernel/cpu/sh4/suspend.c

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index a4c2c84..4b3504b 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -157,6 +157,7 @@ config CPU_SH4
 	bool
 	select CPU_HAS_INTEVT
 	select CPU_HAS_SR_RB
+	select ARCH_SUSPEND_POSSIBLE
 	select CPU_HAS_PTEA if !CPU_SH4A || CPU_SHX2
 	select CPU_HAS_FPU if !CPU_SH4AL_DSP
 
diff --git a/arch/sh/include/cpu-sh4/suspend.h b/arch/sh/include/cpu-sh4/suspend.h
new file mode 100644
index 0000000..4d7dfb7
--- /dev/null
+++ b/arch/sh/include/cpu-sh4/suspend.h
@@ -0,0 +1,260 @@
+/*
+ * -------------------------------------------------------------------------
+ * Copyright (C) 2008  STMicroelectronics
+ * Copyright (C) 2009  STMicroelectronics
+ * Author: Francesco M. Virlinzi  <francesco.virlinzi@st.com>
+ *
+ * May be copied or modified under the terms of the GNU General Public
+ * License V.2 ONLY.  See linux/COPYING for more information.
+ *
+ * ------------------------------------------------------------------------- */
+#ifndef __suspend_sh4_h__
+#define __suspend_sh4_h__
+
+#define BASE_DATA		(0x0)
+	/* to identify the ClockGenA registers */
+#define BASE_CLK		(0x1)
+	/* to identify the ClockGenB registers */
+#define BASE_CLKB		(0x2)
+	/* to identify the Sysconf registers */
+#define BASE_SYS		(0x3)
+
+
+#define OP_END			(0*4)	/* no more data in the table */
+#define OP_END_NO_SLEEP		(1*4)
+#define OP_SOURCE		(2*4)
+#define OP_LOAD			(3*4)	/* load  @(offset, Reg_idx) */
+#define OP_ILOAD_SRC0		(4*4)	/* load_imm (from itable) on r1 */
+#define OP_ILOAD_SRC1		(5*4)	/* load_imm (from itable) on r3 */
+#define OP_ILOAD_SRC2		(6*4)	/* load_imm (from itable) on r4 */
+#define OP_ILOAD_DEST		(7*4)	/* load_imm (from table) on r2 */
+
+#define OP_STORE		(8*4)	/* store @(offset, Reg_idx) */
+#define OP_OR			(9*4)
+#define OP_AND			(10*4)
+#define OP_NOT			(11*4)
+/* WHILE_EQ (idx, offset, mask, value)
+ * wait until the mask bits is equal to value
+ */
+#define OP_WHILE_EQ		(12*4)
+/* WHILE_NEQ (idx, offset, mask, value)
+ * wait until the mask bits isn't equal to value
+ */
+#define OP_WHILE_NEQ		(13*4)
+
+#define OP_DELAY		(14*4)	/* A loop delay */
+
+#define OP_LOAD_SRC0		(15*4)	/* Load SRC_0 from resources */
+#define OP_LOAD_SRC1		(16*4)	/* Load SRC_1 from  */
+#define OP_LOAD_SRC2		(17*4)	/* Load SRC_2 from table */
+#define _OPCODE_TABLE_SIZE_	3
+
+#ifndef __ASSEMBLY__
+
+struct sh4_suspend_t {
+	unsigned long *iobase;   /* the external iomemory resource 		*/
+	unsigned long l_p_j;
+	unsigned long wrt_tbl; /* the writeable table address			*/
+	unsigned long wrt_size; /* the writeable table size in dcache line!	*/
+	unsigned long stby_tbl;	/* the standby instruction table address	*/
+	unsigned long stby_size;/* the standby instruction table size in dcache line*/
+	unsigned long mem_tbl;	/* the mem instruction table address		*/
+	unsigned long mem_size;	/* the mem instruction table size in dcache line*/
+	int (*evt_to_irq)(unsigned long evt); /* translate the INTEVT code
+					       * to the irq number */
+	struct platform_suspend_ops ops;
+};
+
+int sh_register_suspend(struct sh4_suspend_t *pdata);
+
+/* Operations */
+#define _OR()					OP_OR
+#define _AND()					OP_AND
+#define _NOT()					OP_NOT
+#define _DELAY()				OP_DELAY
+#define _WHILE_NEQ()				OP_WHILE_NEQ
+#define _WHILE_EQ()				OP_WHILE_EQ
+#define _LOAD()					OP_LOAD
+#define _STORE()				OP_STORE
+/*
+ * N.S.: DATA_LOAD and DATA_STORE work directly on DEST reg.
+ *       To load something on SCR0, SRC1 and SRC2 Use
+ *       following instructions
+ */
+#define _LOAD_SRC0()				OP_LOAD_SRC0
+#define _LOAD_SRC1()				OP_LOAD_SRC1
+#define _LOAD_SRC2()				OP_LOAD_SRC2
+
+#define _END()					OP_END
+#define _END_NO_SLEEP()				OP_END_NO_SLEEP
+
+#define DATA_SOURCE(idx)					\
+	OP_SOURCE, BASE_DATA, (4*(idx))
+
+#define RAW_SOURCE(orig, reg_offset)				\
+	OP_SOURCE, (4*(orig)), (reg_offset)
+
+#define SYS_SOURCE(reg_offset)					\
+	OP_SOURCE, BASE_SYS, (reg_offset)
+
+#define CLK_SOURCE(reg_offset)					\
+	OP_SOURCE, BASE_CLK, (reg_offset)
+
+#define DATA_LOAD(idx)				DATA_SOURCE(idx), _LOAD()
+#define DATA_STORE(idx)				DATA_SOURCE(idx), _STORE()
+
+/* a raw load */
+#define RAW_LOAD(base, reg_offset)		RAW_SOURCE(base, reg_offset), _LOAD()
+
+#define SYS_LOAD(reg_offset)			RAW_LOAD(BASE_SYS, reg_offset)
+#define CLK_LOAD(reg_offset)			RAW_LOAD(BASE_CLK, reg_offset)
+#define CLKB_LOAD(reg_offset)			RAW_LOAD(BASE_CLKB, reg_offset)
+
+/* A raw store          */
+#define RAW_STORE(base, reg_offset)		RAW_SOURCE(base, reg_offset), _STORE()
+#define SYS_STORE(reg_offset)			RAW_STORE(BASE_SYS, reg_offset)
+#define CLK_STORE(reg_offset)			RAW_STORE(BASE_CLK, reg_offset)
+#define CLKB_STORE(reg_offset)			RAW_STORE(BASE_CLKB, reg_offset)
+
+#define IMMEDIATE_SRC0(value)			OP_ILOAD_SRC0, (value)
+#define IMMEDIATE_SRC1(value)			OP_ILOAD_SRC1, (value)
+#define IMMEDIATE_SRC2(value)			OP_ILOAD_SRC2, (value)
+#define IMMEDIATE_DEST(value)			OP_ILOAD_DEST, (value)
+
+/* Set Or-ing the bits in the register */
+#define RAW_OR_LONG(orig, reg_offset, or_bits)	\
+	RAW_SOURCE(orig, reg_offset),		\
+	 _LOAD(),				\
+	IMMEDIATE_SRC0(or_bits),		\
+	_OR(),					\
+	RAW_SOURCE(orig, reg_offset),		\
+	_STORE()
+
+#define SYS_OR_LONG(reg_offset, or_bits)			\
+	RAW_OR_LONG(BASE_SYS, reg_offset, or_bits)
+
+#define CLK_OR_LONG(reg_offset, or_bits)			\
+	RAW_OR_LONG(BASE_CLK, reg_offset, or_bits)
+
+#define CLKB_OR_LONG(reg_offset, or_bits)			\
+	RAW_OR_LONG(BASE_CLKB, reg_offset, or_bits)
+
+
+#define DATA_OR_LONG(idx_mem, idx_mask)			\
+	DATA_SOURCE(idx_mem),				\
+	_LOAD_SRC0(),					\
+	_LOAD(),					\
+	DATA_SOURCE(idx_mask),				\
+	_LOAD_SRC0(),					\
+	_OR(),						\
+	DATA_SOURCE(idx_mem),				\
+	_LOAD_SRC0(),					\
+	_STORE()
+
+#define DATA_AND_LONG(idx_mem, idx_mask)		\
+	DATA_SOURCE(idx_mem),				\
+	_LOAD_SRC0(),					\
+	_LOAD(),					\
+	DATA_SOURCE(idx_mask),				\
+	_LOAD_SRC0(),					\
+	_AND(),						\
+	DATA_SOURCE(idx_mem),				\
+	_LOAD_SRC0(),					\
+	_STORE()
+
+#define DATA_AND_NOT_LONG(idx_mem, idx_mask)		\
+	DATA_SOURCE(idx_mem),				\
+	_LOAD_SRC0(),					\
+	_LOAD(),					\
+	DATA_SOURCE(idx_mask),				\
+	_LOAD_SRC1(),					\
+	_NOT(),						\
+	_AND(),						\
+	DATA_SOURCE(idx_mem),				\
+	_LOAD_SRC0(),					\
+	_STORE()
+
+/* Set And-ing the bits in the register */
+#define RAW_AND_LONG(orig, reg_offset, and_bits)	\
+	RAW_SOURCE(orig, reg_offset),			\
+	_LOAD(), /* dest = @(iomem) */			\
+	IMMEDIATE_SRC0(and_bits),			\
+	_AND(),	 /* dest &= src0 */			\
+	RAW_SOURCE(orig, reg_offset),			\
+	_STORE() /* @(iomem) = dest */
+
+#define SYS_AND_LONG(reg_offset, and_bits)			\
+		RAW_AND_LONG(BASE_SYS, reg_offset, and_bits)
+
+#define CLK_AND_LONG(reg_offset, and_bits)			\
+		RAW_AND_LONG(BASE_CLK, reg_offset, and_bits)
+
+#define CLKB_AND_LONG(reg_offset, and_bits)			\
+		RAW_AND_LONG(BASE_CLKB, reg_offset, and_bits)
+
+/* Standard Poke */
+#define RAW_POKE(base, reg_offset, value)		\
+	IMMEDIATE_DEST(value),				\
+	RAW_SOURCE(base, reg_offset),			\
+	_STORE()
+
+#define SYS_POKE(reg_offset, value)			\
+	RAW_POKE(BASE_SYS, reg_offset, value)
+
+#define CLK_POKE(reg_offset, value)			\
+	RAW_POKE(BASE_CLK, reg_offset, value)
+
+#define CLKB_POKE(reg_offset, value)			\
+	RAW_POKE(BASE_CLKB, reg_offset, value)
+
+/* While operation */
+#define RAW_WHILE_EQ(orig, offset, mask, value)		\
+	RAW_SOURCE(orig, offset),			\
+	IMMEDIATE_SRC1(mask),				\
+	IMMEDIATE_SRC2(value),				\
+	_WHILE_EQ()
+
+#define RAW_WHILE_NEQ(orig, offset, mask, value)	\
+	RAW_SOURCE(orig, offset),			\
+	IMMEDIATE_SRC1(mask),				\
+	IMMEDIATE_SRC2(value),				\
+	_WHILE_NEQ()
+
+#define DATA_WHILE_EQ(idx_iomem, idx_mask, idx_value)	\
+	DATA_SOURCE(idx_value),				\
+	_LOAD_SRC2(),					\
+	DATA_SOURCE(idx_mask),				\
+	_LOAD_SRC1(),					\
+	DATA_SOURCE(idx_iomem),				\
+	_LOAD_SRC0(),					\
+	_WHILE_EQ()
+
+#define DATA_WHILE_NEQ(idx_iomem, idx_mask, idx_value)	\
+	DATA_SOURCE(idx_value),				\
+	_LOAD_SRC2(),					\
+	DATA_SOURCE(idx_mask),				\
+	_LOAD_SRC1(),					\
+	DATA_SOURCE(idx_iomem),				\
+	_LOAD_SRC0(),					\
+	_WHILE_NEQ()
+
+#define SYS_WHILE_EQ(offset, mask, value)		\
+	RAW_WHILE_EQ(BASE_SYS, offset, mask, value)
+
+#define CLK_WHILE_EQ(offset, mask, value)		\
+	RAW_WHILE_EQ(BASE_CLK, offset, mask, value)
+
+#define CLKB_WHILE_EQ(offset, mask, value)		\
+	RAW_WHILE_EQ(BASE_CLKB, offset, mask, value)
+
+#define SYS_WHILE_NEQ(offset, mask, value)		\
+	RAW_WHILE_NEQ(BASE_SYS, offset, mask, value)
+
+#define CLK_WHILE_NEQ(offset, mask, value)		\
+	RAW_WHILE_NEQ(BASE_CLK, offset, mask, value)
+
+#define CLKB_WHILE_NEQ(offset, mask, value)		\
+	RAW_WHILE_NEQ(BASE_CLKB, offset, mask, value)
+
+#endif
+#endif
diff --git a/arch/sh/kernel/cpu/sh4/Makefile b/arch/sh/kernel/cpu/sh4/Makefile
index d608557..381a331 100644
--- a/arch/sh/kernel/cpu/sh4/Makefile
+++ b/arch/sh/kernel/cpu/sh4/Makefile
@@ -27,3 +27,7 @@ endif
 clock-$(CONFIG_CPU_SUBTYPE_SH4_202)	+= clock-sh4-202.o
 
 obj-y	+= $(clock-y)
+
+ifdef CONFIG_SUSPEND
+obj-y					+= suspend.o suspend-core.o
+endif
diff --git a/arch/sh/kernel/cpu/sh4/suspend-core.S b/arch/sh/kernel/cpu/sh4/suspend-core.S
new file mode 100644
index 0000000..79fa5f3
--- /dev/null
+++ b/arch/sh/kernel/cpu/sh4/suspend-core.S
@@ -0,0 +1,350 @@
+/*
+ * -------------------------------------------------------------------------
+ * <linux_root>/arch/sh/kernel/cpu/sh4/suspend-core.S
+ * -------------------------------------------------------------------------
+ * Copyright (C) 2008  STMicroelectronics
+ * Copyright (C) 2009  STMicroelectronics
+ * Author: Francesco M. Virlinzi  <francesco.virlinzi@st.com>
+ *
+ * May be copied or modified under the terms of the GNU General Public
+ * License V.2 ONLY.  See linux/COPYING for more information.
+ *
+ * ------------------------------------------------------------------------- */
+
+#include <cpu-sh4/suspend.h>
+#include <cpu-sh4/cpu/mmu_context.h>
+/*
+ * Some register are dedicated for special purpose
+ */
+#define IOREGS_BASE		r14
+#define ITABLE_ADDRESS		r13
+#define DTABLE_ADDRESS		r12
+#define DELAY_REG		r11
+
+#define OFFSET_IOBASE		0x0
+#define OFFSET_LPJ		0x4
+#define OFFSET_DTABLE		0x8
+#define OFFSET_DTABLE_SIZE	0xc
+#define REG_INSTR		r5
+#define REG_INSTR_END		r6
+
+
+#define JUMPER()		bra 201f;	\
+				 nop;		\
+			200:	bra 200f;	\
+				 nop;	;	\
+			201:
+
+#undef ENTRY
+#define ENTRY(name, align)	\
+  .balign align;		\
+  .globl name;			\
+  name:
+
+.text
+ENTRY(sh4_suspend, 32)		! to be icache aligned
+	bra 200f		! start the jump sequence
+	 nop
+sh4_really_suspend:
+	mov.l   r14, @-r15
+	mov.l   r13, @-r15
+	mov.l   r12, @-r15
+	mov.l   r11, @-r15
+	mov.l   r10, @-r15
+	mov.l   r9,  @-r15
+	mov.l   r8,  @-r15
+	sts.l	pr,  @-r15	! save the pr (we can call other function)
+	stc.l	sr,  @-r15
+	stc	vbr, r0
+
+	JUMPER()
+
+	mov.l	r0,  @-r15	! save the original vbr on the stack
+
+	mov.l	@(OFFSET_IOBASE, r4), IOREGS_BASE	! save ioregs address
+	mov.l	@(OFFSET_LPJ, r4),    DELAY_REG
+	mov.l	@(OFFSET_DTABLE, r4), DTABLE_ADDRESS
+	mov	REG_INSTR,  	      ITABLE_ADDRESS	! the instruction table!
+
+/*
+ *	runs the suspend iteration tables
+ */
+	bsr	do_decode
+	 nop
+
+	cmp/eq  #1, r0		! check if we have to sleep or not
+	bt	__resume	! it depends if we complete the table
+				! with END or END_NO_SLEEP
+
+	mova	vbr_base_suspend, r0	! this mova isn't a problem
+					! because vbr_base_suspend is
+					! 4 bytes alligned
+	ldc	r0, vbr			! install the wakeup_interrupt
+	mov	#0x3c, r1
+
+	JUMPER()
+
+	shll2	r1
+	not	r1,   r1
+	stc	sr,   r0
+	and	r1,   r0
+	ldc	r0,   sr		! enable the interrups
+
+	sleep				! SLEEP!!!
+
+/*
+ *	runs the resume instruction tables
+ */
+__resume:
+	nop
+	bsr     do_decode
+	 nop
+
+	mov.l	@r15+, r0
+	ldc	r0,    vbr		! Restore the original vbr
+	mov.l	@r15+, r0		! Original sr (on interrupts disabled)
+
+	JUMPER()
+
+	lds.l	@r15+, pr
+	mov.l   @r15+, r8
+	mov.l   @r15+, r9
+	mov.l   @r15+, r10
+	mov.l   @r15+, r11
+	mov.l   @r15+, r12
+	mov.l   @r15+, r13
+	mov.l	@r15+, r14
+	mov.l   1f,  r1
+	mov.l   @r1, r1			! who waked up
+	ldc	r0, sr			! Restore the original sr
+	rts
+	 mov	r1, r0			! who waked up
+	JUMPER()
+
+.balign 4
+1:			.long	INTEVT
+
+
+.balign       	1024,	0,	1024
+vbr_base_suspend:
+	.long   0
+.balign         1024,   0,      1024
+
+	.long 0
+.balign         512,	0,	512
+wakeup_interrupt:
+	JUMPER()
+	!	Disable the interrupts in the ssr
+	!	and returns to the context (asap)....
+	stc	ssr,   r0
+	or	#0xf0, r0
+	ldc	r0, ssr		! to avoit recursive irq...
+				! this means the context will be resumed
+				! with interrupt disabled!!!
+/*
+ * Here we could have a problem (a sleep with interrupt disables!!!)
+ * It could happen if we detect an interrupt between
+ * the enabled irq and the sleep!!!
+ * Restoring the (raw) spc we will go to execute a sleep with the
+ * interrupt disabled !!!!
+ * To avoid that in any case we will return on the resume_address
+ * label
+ */
+	mov.l	resume_address, r0
+	ldc	r0, spc
+	rte
+	 nop
+
+200:
+/*
+ *	load the instruction datas
+ */
+	mov.l   resume_address,	r0
+	mov	REG_INSTR, r0		/* start address I-table */
+	mov	REG_INSTR_END, r1	/* I-table size */
+	tst	r1, r1
+2:
+	mov.l   @r0, r2			/* Load the I-tables in cache */
+	add	#32, r0
+        bf/s	2b
+         dt	r1
+/*
+ *      load the writeable datas
+ */
+	mov.l	@(OFFSET_DTABLE, r4), r0
+	mov.l	@(OFFSET_DTABLE_SIZE, r4),   r1
+	tst	r1, r1
+2:
+	mov.l   @r0, r2			/* Load the d-tables in cache */
+	add	#32, r0
+	bf/s	2b
+	 dt	r1
+	bra	200f
+	 nop
+
+.balign 4
+resume_address:		.long __resume
+
+#define SRC0		r1
+#define SRC1		r2
+#define SRC2		r3
+#define DEST		r4
+#define TMP		r5
+
+.balign 2
+	JUMPER()
+ENTRY(do_decode, 2)
+	mov.l	@ITABLE_ADDRESS+, r0	! opcode
+	mov.l	s_jmp_table_address, TMP
+	mov.l	@(r0, TMP), TMP
+	jmp	@TMP
+	 nop
+
+l_end:	! OP_END
+	rts				! Return point
+	 mov	#0, r0			! r0 = 0 to say return and sleep
+
+	JUMPER()
+
+l_end_no_sleep:	! OP_END_NO_SLEEP
+	rts				! Return point
+	 mov	#1, r0			! r0 = 1 to say return and Don't sleep
+
+l_source: ! OP_SOURCE
+	mov.l	@ITABLE_ADDRESS+, r0	! load the source reg base
+	mov.l	@(r0, IOREGS_BASE), TMP	! load ioreg in r5
+	mov.l	@ITABLE_ADDRESS+, SRC0	! load the offset
+	bra     do_decode
+	 add	TMP, SRC0		! r2 = the iomem address of source
+
+	JUMPER()
+
+	/* Load a @SRC0 in Dest*/
+l_load: ! #OP_LOAD
+	bra	do_decode
+	 mov.l	@SRC0, DEST		! load the value
+
+	/* Load a value from table in SRC0 */
+l_iload_scr0: ! OP_ILOAD_SRC0
+	bra	do_decode
+	 mov.l	@ITABLE_ADDRESS+, SRC0	! the value is in SRC0 !!!
+
+	/* Load a value from table in SRC1 */
+l_iload_src1: ! OP_ILOAD_SRC1
+	bra	do_decode
+	 mov.l	@ITABLE_ADDRESS+, SRC1	! the value is in SRC1 !!!
+
+	/* Load a value from table in SRC2 */
+l_iload_src2: ! OP_ILOAD_SRC2
+	bra	do_decode
+	 mov.l @ITABLE_ADDRESS+, SRC2	! the value is in SRC2 !!!
+
+	/* Load a value from table in the DEST */
+l_iload_dest: ! OP_ILOAD_DEST
+	bra	do_decode
+	 mov.l @ITABLE_ADDRESS+, DEST
+
+	JUMPER()
+
+	/* Store DEST value in @SRC0 */
+l_store: ! OP_STORE
+	bra	do_decode
+	 mov.l DEST, @(0,SRC0)		! store the value
+
+	/* Or operation: DEST |= SRC0 */
+l_or:	! OP_OR
+	bra	do_decode
+	 or	SRC0, DEST
+
+	/* And operation: DEST &= SRC0 */
+l_and:	! OP_AND
+	bra	do_decode
+	 and	SRC0, DEST
+
+	/* Not operation: SRC0 = ~SRC1*/
+	/* It's a bit dirty that the NOT operation works on SRC1 instead of DEST or SRC0*/
+l_not:	! OP_NOT
+	bra	do_decode
+	 not	SRC1, SRC0
+
+	JUMPER()
+
+	/* While bits equal to value. This operation assumes:
+		- SRC0: the iomemory address
+		- SRC1: the bitmask
+		- SRC2: the result
+	*/
+l_while_eq: !	OP_WHILE_EQ
+	mov.l	@SRC0, TMP
+2:	and     SRC1, TMP
+	cmp/eq	SRC2, TMP			! (@SRC0 and SRC1) ?!= SRC2)
+	bt/s	2b
+	 mov.l   @SRC0, TMP
+	bra	do_decode
+	 nop
+
+	JUMPER()
+	/* While bits not equal to value. This operation assumes:
+		   - SRC0: the iomemory address
+		   - SRC1: the bitmask
+		   - SRC2: the result
+	*/
+l_while_neq: ! OP_WHILE_NEQ
+	mov.l	@SRC0, TMP
+2:	and	SRC1, TMP
+	cmp/eq  SRC2, TMP		! (@SRC0 and SRC1) ?== SRC2)
+	bf/s	2b
+	 mov.l	@SRC0, TMP
+	bra	do_decode
+	 nop
+
+	JUMPER()
+
+	/* Delay operation */
+l_delay: ! OP_DELAY
+	mov     DELAY_REG, TMP
+	tst	TMP, TMP
+2:
+	bf/s   2b
+	 dt	TMP
+	bra	do_decode
+	 nop
+
+	/*  SCR0 = @SRC0 */
+l_load_src0: ! OP_LOAD_SRC0
+	mov.l	@SRC0, SRC0
+	bra	do_decode
+	 nop
+
+	JUMPER()
+
+l_load_src1: ! OP_LOAD_SRC1	=> SRC1 = @SRC0
+	mov.l  @SRC0, SRC1
+	bra	do_decode
+	 nop
+
+l_load_src2: ! OP_LOAD_SRC2	=> SRC2 = @SRC0
+	mov.l  @SRC0, SRC2
+	bra	do_decode
+	 nop
+
+200:	! Preload the jump table
+	mov.l	s_jmp_table_address, r1
+	mov	#_OPCODE_TABLE_SIZE_, r0
+	cmp/eq	#0, r0
+load_jtable:
+	mov.l	@r1, r2
+	add	#32, r1
+	bf/s	load_jtable
+	 dt	r0
+
+	bra sh4_really_suspend		! Now we jump on sh4_really_suspend
+	 nop				! to really suspend (and resume... ;-)
+
+.balign 32
+s_jmp_table:
+.long l_end, l_end_no_sleep, l_source, l_load, l_iload_scr0, l_iload_src1, l_iload_src2, l_iload_dest 
+.long l_store, l_or, l_and, l_not, l_while_eq, l_while_neq, l_delay, l_load_src0
+.long l_load_src1, l_load_src2   
+s_jmp_table_address:
+.long s_jmp_table
diff --git a/arch/sh/kernel/cpu/sh4/suspend.c b/arch/sh/kernel/cpu/sh4/suspend.c
new file mode 100644
index 0000000..754de56
--- /dev/null
+++ b/arch/sh/kernel/cpu/sh4/suspend.c
@@ -0,0 +1,113 @@
+/*
+ * -------------------------------------------------------------------------
+ * <linux_root>/arch/sh/kernel/suspend.c
+ * -------------------------------------------------------------------------
+ * Copyright (C) 2008  STMicroelectronics
+ * Copyright (C) 2009  STMicroelectronics
+ * Author: Francesco M. Virlinzi  <francesco.virlinzi@st.com>
+ *
+ * May be copied or modified under the terms of the GNU General Public
+ * License V.2 ONLY.  See linux/COPYING for more information.
+ *
+ * ------------------------------------------------------------------------- */
+
+#include <linux/init.h>
+#include <linux/suspend.h>
+#include <linux/errno.h>
+#include <linux/time.h>
+#include <linux/delay.h>
+#include <linux/irqflags.h>
+#include <linux/kobject.h>
+#include <linux/stat.h>
+#include <linux/clk.h>
+#include <linux/hardirq.h>
+#include <linux/jiffies.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm-generic/bug.h>
+#include <cpu-sh4/suspend.h>
+#undef  dbg_print
+
+#ifdef CONFIG_PM_DEBUG
+#define dbg_print(fmt, args...)		\
+		printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
+#else
+#define dbg_print(fmt, args...)
+#endif
+
+
+static struct sh4_suspend_t *sh4_data;
+
+unsigned long sh4_suspend(struct sh4_suspend_t *pdata,
+	unsigned long instr_tbl, unsigned long instr_tbl_end);
+
+static inline unsigned long _10_ms_lpj(void)
+{
+	static struct clk *sh4_clk;
+
+	if (!sh4_clk)
+		sh4_clk = clk_get(NULL, "sh4_clk");
+
+	return clk_get_rate(sh4_clk) / (100 * 2);
+}
+
+static int sh4_suspend_enter(suspend_state_t state)
+{
+	unsigned long flags;
+	unsigned long instr_tbl, instr_tbl_end;
+	unsigned long wokenup_by;
+
+	sh4_data->l_p_j = _10_ms_lpj();
+
+	/* Must wait for serial buffers to clear */
+	mdelay(500);
+
+	local_irq_save(flags);
+
+	/* sets the right instruction table */
+	if (state == PM_SUSPEND_STANDBY) {
+		instr_tbl     = sh4_data->stby_tbl;
+		instr_tbl_end = sh4_data->stby_size;
+	} else {
+		instr_tbl     = sh4_data->mem_tbl;
+		instr_tbl_end = sh4_data->mem_size;
+	}
+
+	BUG_ON(in_irq());
+
+	wokenup_by = sh4_suspend(sh4_data, instr_tbl, instr_tbl_end);
+
+/*
+ *  without the evt_to_irq function the INTEVT is returned
+ */
+	if (sh4_data->evt_to_irq)
+		wokenup_by = sh4_data->evt_to_irq(wokenup_by);
+
+	BUG_ON(in_irq());
+
+	local_irq_restore(flags);
+
+	printk(KERN_INFO "sh4 woken up by: 0x%x\n", wokenup_by);
+
+	return 0;
+}
+
+static int sh4_suspend_valid_both(suspend_state_t state)
+{
+	return 1;
+}
+
+int sh_register_suspend(struct sh4_suspend_t *pdata)
+{
+	sh4_data = pdata;
+	sh4_data->ops.enter = sh4_suspend_enter;
+	if (sh4_data->stby_tbl)
+		sh4_data->ops.valid = sh4_suspend_valid_both;
+	else
+		sh4_data->ops.valid = suspend_valid_only_mem;
+	suspend_set_ops(&sh4_data->ops);
+
+	printk(KERN_INFO "sh4 suspend support registered\n");
+
+	return 0;
+}
-- 
1.5.6.6


--------------000306040007000300060604--
