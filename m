From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Fri, 04 Dec 2009 14:52:45 +0000
Subject: [PATCH (sh-2.6.30.y) 03/13] stm: pm: Add Suspend/Standby support on K200 kernel
Message-Id: <1259938375-27499-3-git-send-email-francesco.virlinzi@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds the Suspend/Standby support to the k200 kernel.
Now the interpreter uses the same grammar of PBL/U-Boot

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/kernel/pm/Makefile           |   16 ++
 arch/sh/kernel/pm/stm_suspend-core.S |  376 ++++++++++++++++++++++++++++++++++
 arch/sh/kernel/pm/stm_suspend.c      |  133 ++++++++++++
 arch/sh/kernel/pm/stm_suspend.h      |  138 +++++++++++++
 4 files changed, 663 insertions(+), 0 deletions(-)
 create mode 100644 arch/sh/kernel/pm/Makefile
 create mode 100644 arch/sh/kernel/pm/stm_suspend-core.S
 create mode 100644 arch/sh/kernel/pm/stm_suspend.c
 create mode 100644 arch/sh/kernel/pm/stm_suspend.h

diff --git a/arch/sh/kernel/pm/Makefile b/arch/sh/kernel/pm/Makefile
new file mode 100644
index 0000000..0e41d1a
--- /dev/null
+++ b/arch/sh/kernel/pm/Makefile
@@ -0,0 +1,16 @@
+#
+# Makefile for the Linux/ST40 PM support
+#
+
+ifdef CONFIG_SUSPEND
+obj-y					+= stm_suspend.o stm_suspend-core.o
+obj-$(CONFIG_CPU_SUBTYPE_STX5197)	+= suspend-stx5197.o
+obj-$(CONFIG_CPU_SUBTYPE_STX5206)	+= suspend-stx5206.o
+obj-$(CONFIG_CPU_SUBTYPE_STX7100)	+= suspend-stx7100.o suspend-stx7100_t.o
+obj-$(CONFIG_CPU_SUBTYPE_STX7105)	+= suspend-stx7105.o
+obj-$(CONFIG_CPU_SUBTYPE_STX7111)	+= suspend-stx7111.o
+obj-$(CONFIG_CPU_SUBTYPE_STX7141)	+= suspend-stx7141.o
+obj-$(CONFIG_CPU_SUBTYPE_STX7200)	+= suspend-stx7200.o
+endif
+
+obj-$(CONFIG_HIBERNATION)		+= stm_swsusp.o
diff --git a/arch/sh/kernel/pm/stm_suspend-core.S b/arch/sh/kernel/pm/stm_suspend-core.S
new file mode 100644
index 0000000..5b61940
--- /dev/null
+++ b/arch/sh/kernel/pm/stm_suspend-core.S
@@ -0,0 +1,376 @@
+/*
+ * -------------------------------------------------------------------------
+ * <linux_root>/arch/sh/kernel/cpu/sh4/stm_suspend-core.S
+ * -------------------------------------------------------------------------
+ * Copyright (C) 2009  STMicroelectronics
+ * Author: Francesco M. Virlinzi  <francesco.virlinzi@st.com>
+ *
+ * May be copied or modified under the terms of the GNU General Public
+ * License V.2 ONLY.  See linux/COPYING for more information.
+ *
+ * ------------------------------------------------------------------------- */
+
+#include <linux/linkage.h>
+#include <cpu/mmu_context.h>
+#include "stm_suspend.h"
+
+#define JUMPER()		bra 81f;	\
+				 nop;		\
+			8:	bt 8f;		\
+			81:
+
+
+#undef ENTRY
+#define ENTRY(name, align)	\
+  .balign align;		\
+  .globl name;			\
+  name:
+
+.text
+ENTRY(stm_suspend, 2)
+	mov.l   r13,  @-r15
+	sett
+	bt/s 8f			! start the jump sequence
+	 sts.l	pr,  @-r15
+
+.balign 32
+8:	bt	8f
+stm_really_suspend:
+ 	! runs the suspend instruction table
+	bsr	DoPoking
+	 mov	r13, r0
+
+	mov	r7, r0
+	tst	#1, r0			! checks NO_SLEEP flag
+	bf	cpu_resume
+
+	mov	#0x60, r0
+	shll2	r0
+	shll2	r0
+	mov	r0, r1			! r1 = 0x600
+	mova	wakeup_interrupt, r0
+
+	sub	r1, r0
+	ldc	r0, vbr			! installs the wakeup_interrupt
+
+	mov	#0x3c, r1
+	shll2	r1
+	not	r1,   r1		! 16
+
+	JUMPER()
+	stc	sr,   r0
+	and	r1,   r0
+	ldc	r0,   sr		! enables the interrupts
+
+	sleep				! SLEEP!!!
+
+.balign		32, 0, 32
+wakeup_interrupt:
+	JUMPER()
+
+	! Reset SR.RB bit
+	mov.l	11f, r0
+	stc	sr, r1
+	and	r0, r1
+	ldc	r1, sr		! on the main bank
+
+	! Restore the Linux vbr
+	mov.l	10f, r0
+	ldc	r0,  vbr
+
+	! check for early action with SR.BL bit equal 1
+	mov	r7, r0
+	tst	#2, r0		! check EARLY_ACTION flag
+	bt	1f
+
+	! runs the early_action instruction table
+	bsr	DoPoking
+	 mov	r13, r0
+1:
+	! Set SR.IMASK and reset SR.BL
+	stc	sr, r0
+	or	#0xf0,r0	! 16
+	mov.l	12f, r1
+	and	r1, r0
+	ldc	r0, sr
+	bra	cpu_resume
+	 nop
+.balign		4
+cpu_resume:
+	! runs the resume instruction table
+	bsr     DoPoking
+	 mov	r13, r0
+
+	lds.l	@r15+, pr
+	rts
+	 mov.l   @r15+, r13
+
+8:
+	mov.l	10f, r0
+	mov.l	11f, r0
+	mov.l   12f, r0
+	bt	8f
+
+.balign 4
+10:	.long vbr_base
+11:	.long ~(1 << 29)	! to reset the SR.RB bit
+12:	.long ~(1 << 28)	! to reset the SR.BL bit
+
+/*
+ * The poke table is a series of long words, in the format:
+ *
+ *	opcode, operand, operand (, operand)*
+ *
+ * An opcode of 0 marks the table end.
+ *
+ * The DoPoking comes direclty from PBL.
+ *
+ */
+
+.balign	32
+8:	bt	8f
+DoPoking:
+	mov.l	@r4+, r5	/* opcode */
+	mov.l	@r4+, r1	/* operand 1 */
+	mov.l	@r4+, r2	/* operand 2 */
+
+	mov.b	@(r0, r5), r5
+	extu.b	r5, r5
+	braf	r5
+	  nop
+SwitchJumpFrom:
+
+/* END_MARKER */
+DoRet:
+	rts			/* Return point */
+	 add #-8, r4
+
+/* POKE8(A, VAL) */
+DoPoke8:
+	bra	DoPoking
+	  mov.b	r2, @r1		/* *A = VAL */
+
+/* POKE16(A, VAL) */
+DoPoke16:
+	bra	DoPoking
+	  mov.w	r2, @r1		/* *A = VAL */
+
+/* POKE32(A, VAL) */
+DoPoke32:
+	bra	DoPoking
+	  mov.l	r2, @r1		/* *A = VAL */ ! 16
+
+/* OR8(A, VAL) */
+DoOr8:
+	mov.b	@r1, r3		/* *A */
+	or	r2, r3		/* *A | OR */
+	bra	DoPoking
+	  mov.b	r3, @r1		/* *A |= OR */
+8:	bt	8f
+
+/* OR16(A, VAL) */
+DoOr16:
+	mov.w	@r1, r3		/* *A */
+	or	r2, r3		/* *A | OR */
+	bra	DoPoking
+	  mov.w	r3, @r1		/* *A |= OR */
+
+/* OR32(A, VAL) */
+DoOr32:
+	mov.l	@r1, r3		/* *A */
+	or	r2, r3		/* *A | OR */
+	bra	DoPoking
+	  mov.l	r3, @r1		/* *A |= OR */
+
+/* UPDATE8(A, AND, OR) */
+DoUpdate8:
+	mov.b	@r1, r3		/* *A */
+	and	r2, r3		/* *A & AND */
+	mov.b	@r4+, r2	/* read OR */ !16
+	add	#3, r4
+	or	r2, r3		/* (*A & AND) | OR */
+	bra	DoPoking
+	  mov.b	r3, @r1		/* *A = ((*A & AND) | OR) */
+
+8:	bt	8f
+/* UPDATE16(A, AND, OR) */
+DoUpdate16:
+	mov.w	@r1, r3		/* *A */
+	and	r2, r3		/* *A & AND */
+	mov.w	@r4+, r2	/* read OR */
+	add	#2, r4
+	or	r2, r3		/* (*A & AND) | OR */
+	bra	DoPoking
+	  mov.w	r3, @r1		/* *A = ((*A & AND) | OR) */
+
+/* UPDATE32(A, AND, OR) */
+DoUpdate32:
+	mov.l	@r1, r3		/* *A */
+	and	r2, r3		/* *A & AND */
+	mov.l	@r4+, r2	/* read OR */
+	or	r2, r3		/* (*A & AND) | OR */
+	bra	DoPoking
+	  mov.l	r3, @r1		/* *A = ((*A & AND) | OR) */
+
+8:	bt	8f
+/* POKE_UPDATE32(A1, A2, AND, SHIFT, OR) */
+DoPokeUpdate32:
+	mov.l	@r2, r3		/* *A2 */
+	mov.l	@r4+, r2	/* read AND */
+	and	r2, r3		/* *A2 & AND */
+	mov.l	@r4+, r2	/* read SHIFT */
+	shld	r2, r3		/* (*A2 & AND) << SHIFT */
+	mov.l	@r4+, r2	/* read OR */
+	or	r2, r3		/* ((*A2 & AND) << SHIFT) | OR */
+	bra	DoPoking
+	  mov.l	r3, @r1		/* *A1 = (((*A2 & AND) << SHIFT) | OR) */
+
+/* WHILE_NE8(A, AND, VAL) */
+DoWhileNe8:
+	mov.l	@r4+, r5	/* read VAL */
+1:	mov.b	@r1, r3		/* *A */
+	extu.b	r3, r3		/* 32bit(*A) */
+	and	r2, r3		/* *A & AND */
+	cmp/eq	r3, r5		/* if ((*A & AND) = VAL) */
+	bf	1b		/* loop if false */
+	bt	DoPoking
+
+8:	bt	8f
+/* WHILE_NE16(A, AND, VAL) */
+DoWhileNe16:
+	mov.l	@r4+, r5	/* read VAL */
+1:	mov.w	@r1, r3		/* *A */
+	extu.w	r3, r3		/* 32bit(*A) */
+	and	r2, r3		/* *A & AND */
+	cmp/eq	r3, r5		/* if ((*A & AND) = VAL) */
+	bf	1b		/* loop if false */
+	bt	DoPoking
+
+/* WHILE_NE32(A, AND, VAL) */
+DoWhileNe32:
+	mov.l	@r4+, r5	/* read VAL */
+1:	mov.l	@r1, r3		/* *A */
+	and	r2, r3		/* *A & AND */
+	cmp/eq	r3, r5		/* if ((*A & AND) = VAL) */
+	bf	1b		/* loop if false */
+	bt	DoPoking
+8:	bt	8f
+
+/* IF_EQ32(NESTLEVEL, A, AND, VAL)
+   Note that NESTLEVEL is not in the actual table, but there is a distance
+   field following VAL.
+ */
+DoIfEq32:
+	mov.l	@r1, r1		/* *A */
+	and	r2, r1		/* *A & AND */
+	mov.l	@r4+, r2	/* read VAL */
+	mov.l	@r4+, r3	/* read distance to ELSE/ENDIF */
+	cmp/eq	r2, r1		/* if ((*A & AND) = VAL) */
+	bt	DoPoking	/* go ahead with these pokes */
+	add	r3, r4		/* skip forward through pokes to ELSE or ENDIF*/
+	bf	DoPoking
+
+/* IF_GT32(NESTLEVEL, A, AND, VAL)
+   Note that NESTLEVEL is not in the actual table, but there is a distance
+   field following VAL.
+ */
+8:	bt	8f
+DoIfGT32:
+	mov.l	@r1, r1		/* *A */
+	and	r2, r1		/* *A & AND */
+	mov.l	@r4+, r2	/* read VAL */
+	mov.l	@r4+, r3	/* read distance to ELSE/ENDIF */
+	cmp/hi	r2, r1		/* if ((*A & AND) > VAL) */
+	bt	DoPoking	/* go ahead with these pokes if true*/
+	add	r3, r4		/* skip forward through pokes to ELSE or ENDIF*/
+	bf	DoPoking
+
+/* ELSE(NESTLEVEL)
+   Note that NESTLEVEL is not in the actual table, but there is a distance
+   field following the opcode.
+ */
+DoElse:
+	add	#-4, r4		/* We took 1 arg too many from r4 for a delay */
+	bra	DoPoking
+	  add	r1, r4		/* skip through to ENDIF */
+
+8:	bt	8f
+/* DELAY(ITERATIONS) */
+DoDelay:
+	mov	r6, r2		/* _1_ms_lpj */
+	tst	r2, r2
+2:	bf/s	2b
+	 dt	r2
+	tst	r1, r1
+	bf/s	DoDelay
+	 dt	r1
+	bra	DoPoking
+	 add	#-4, r4		/* We took 1 arg too many from r4 for a delay */
+
+/* IF_DEVID_GE(NESTLEVEL, VAL)
+   Note that NESTLEVEL is not in the actual table, but there is a distance
+   field following VAL.
+ */
+DoIfDevIDGE:
+	cmp/hs	r1, r5		/* if (device ID >= VAL) */
+	bt	DoPoking	/* go ahead with these pokes if true */
+	bra	DoPoking
+	  add	r2, r4
+
+8:	bt	8f
+/* IF_DEVID_LE(NESTLEVEL, VAL)
+   Note that NESTLEVEL is not in the actual table, but there is a distance
+   field following VAL.
+ */
+DoIfDevIDLE:
+	cmp/hi	r5, r1		/* if (device ID <= VAL) */
+	bt	1f		/* go ahead with these pokes if true */
+	add	r2, r4
+1:	bra	DoPoking
+	  nop
+
+8:
+/*
+ *	preload the instruction datas
+ */
+	mov	r4, r0			/* start address I-table */
+	tst	r5, r5
+2:
+	mov.l   @r0, r2			/* Load the I-tables in cache */
+	add	#32, r0
+        bf/s	2b
+         dt	r5
+
+	/* Ensure the jump table is in the data cache */
+	mova	SwitchJumpTable, r0	/* Keep this in r0 for use in DoPoking*/
+	mov	r0, r13
+	bra	stm_really_suspend
+	 mov.l	@r0, r0
+
+/* The SwitchJumpTable must be in increasing numeric order of opcode (with
+ * padding for any missing entries).  Distance between SwitchJumpTable and any
+ * of the operations must be less than 255 bytes (the assembler should point it
+ * out if we ever break that condition and have to switch to 16 bit values).
+ */
+	.balign 32
+SwitchJumpTable:
+        .byte   DoRet - SwitchJumpFrom
+        .byte   DoPoke8 - SwitchJumpFrom
+        .byte   DoPoke16 - SwitchJumpFrom
+        .byte   DoPoke32 - SwitchJumpFrom
+        .byte   DoOr8 - SwitchJumpFrom
+        .byte   DoOr16 - SwitchJumpFrom
+        .byte   DoOr32 - SwitchJumpFrom
+        .byte   DoUpdate8 - SwitchJumpFrom
+        .byte   DoUpdate16 - SwitchJumpFrom
+        .byte   DoUpdate32 - SwitchJumpFrom
+        .byte   DoPokeUpdate32 - SwitchJumpFrom
+        .byte   DoWhileNe8 - SwitchJumpFrom
+        .byte   DoWhileNe16 - SwitchJumpFrom
+        .byte   DoWhileNe32 - SwitchJumpFrom
+        .byte   DoIfEq32 - SwitchJumpFrom
+        .byte   DoIfGT32 - SwitchJumpFrom
+        .byte   DoElse - SwitchJumpFrom
+        .byte   DoDelay - SwitchJumpFrom
+        .byte   DoIfDevIDGE - SwitchJumpFrom
+        .byte   DoIfDevIDLE - SwitchJumpFrom
diff --git a/arch/sh/kernel/pm/stm_suspend.c b/arch/sh/kernel/pm/stm_suspend.c
new file mode 100644
index 0000000..8297972
--- /dev/null
+++ b/arch/sh/kernel/pm/stm_suspend.c
@@ -0,0 +1,133 @@
+/*
+ * -------------------------------------------------------------------------
+ * <linux_root>/arch/sh/kernel/suspend-st40.c
+ * -------------------------------------------------------------------------
+ * Copyright (C) 2008  STMicroelectronics
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
+#include <asm/cacheflush.h>
+#include <asm-generic/bug.h>
+
+#include <cpu/mmu_context.h>
+#include "stm_suspend.h"
+
+#undef  dbg_print
+
+#ifdef CONFIG_PM_DEBUG
+#define dbg_print(fmt, args...)		\
+		printk(KERN_INFO "%s: " fmt, __func__, ## args)
+#else
+#define dbg_print(fmt, args...)
+#endif
+
+unsigned int wokenup_by;
+
+static inline unsigned long _1_ms_lpj(void)
+{
+	static struct clk *sh4_clk;
+	if (!sh4_clk)
+		sh4_clk = clk_get(NULL, "sh4_clk");
+	return clk_get_rate(sh4_clk) / (1000 * 2);
+}
+
+static struct stm_suspend_t *soc_suspend;
+
+unsigned long stm_read_intevt(void)
+{
+	unsigned long evt = INTEVT;
+	asm volatile(
+		"mov.l	@%0, %0	\n"
+		: "+r" (evt));
+
+	return evt;
+}
+
+static int stm_suspend_enter(suspend_state_t state)
+{
+	unsigned long soc_flags;
+	unsigned long tbl, tbl_size;
+	unsigned long lpj = _1_ms_lpj();
+
+	/* Must wait for serial buffers to clear */
+	printk(KERN_INFO "CPU is sleeping\n");
+	mdelay(500);
+
+	/* sets the right instruction table */
+	if (state = PM_SUSPEND_STANDBY) {
+		tbl = soc_suspend->stby_tbl;
+		tbl_size = soc_suspend->stby_size;
+		soc_flags = ((soc_suspend->flags & NO_SLEEP_ON_STANDBY)
+				? 1 : 0);
+		soc_flags += ((soc_suspend->flags & EARLY_ACTION_ON_STANDBY)
+				? 2 : 0);
+	} else {
+		tbl = soc_suspend->mem_tbl;
+		tbl_size = soc_suspend->mem_size;
+		soc_flags = ((soc_suspend->flags & NO_SLEEP_ON_MEMSTANDBY)
+				? 1 : 0);
+		soc_flags += ((soc_suspend->flags & EARLY_ACTION_ON_MEMSTANDBY)
+				? 2 : 0);
+	}
+
+	flush_cache_all();
+
+	BUG_ON(in_irq());
+
+	stm_suspend(tbl, tbl_size, lpj, soc_flags);
+
+	BUG_ON(in_irq());
+
+	wokenup_by = stm_read_intevt();
+/*
+ *  without the evt_to_irq function the INTEVT is returned
+ */
+	if (soc_suspend->evt_to_irq)
+		wokenup_by = soc_suspend->evt_to_irq(wokenup_by);
+
+	printk(KERN_INFO "CPU woken up by: 0x%x\n", wokenup_by);
+
+	return 0;
+}
+
+static int stm_suspend_valid_both(suspend_state_t state)
+{
+	return 1;
+}
+
+int __init stm_suspend_register(struct stm_suspend_t *_suspend)
+{
+	if (!_suspend)
+		return -EINVAL;
+
+	soc_suspend = _suspend;
+	soc_suspend->ops.enter = stm_suspend_enter;
+
+	if (soc_suspend->stby_tbl && soc_suspend->stby_size)
+		soc_suspend->ops.valid = stm_suspend_valid_both;
+	else
+		soc_suspend->ops.valid = suspend_valid_only_mem;
+
+	suspend_set_ops(&soc_suspend->ops);
+
+	printk(KERN_INFO "[STM]: [PM]: Suspend support registered\n");
+
+	return 0;
+}
diff --git a/arch/sh/kernel/pm/stm_suspend.h b/arch/sh/kernel/pm/stm_suspend.h
new file mode 100644
index 0000000..a2ec5b2
--- /dev/null
+++ b/arch/sh/kernel/pm/stm_suspend.h
@@ -0,0 +1,138 @@
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
+#ifndef __stm_suspend_h__
+#define __stm_suspend_h__
+
+/* Opcode values */
+#define OP_END_POKES					0
+#define OP_POKE8					1
+#define OP_POKE16					2
+#define OP_POKE32					3
+#define OP_OR8						4
+#define OP_OR16						5
+#define OP_OR32						6
+#define OP_UPDATE8					7
+#define OP_UPDATE16					8
+#define OP_UPDATE32					9
+#define OP_POKE_UPDATE32				10
+#define OP_WHILE_NE8					11
+#define OP_WHILE_NE16					12
+#define OP_WHILE_NE32					13
+#define OP_IF_EQ32					14
+#define OP_IF_GT32					15
+#define OP_ELSE						16
+#define OP_DELAY					17
+#define OP_IF_DEVID_GE					18
+#define OP_IF_DEVID_LE					19
+
+#ifdef __ASSEMBLER__
+
+/* Poke table commands */
+#define POKE8(A, VAL)				.long OP_POKE8, A, VAL
+#define POKE16(A, VAL)				.long OP_POKE16, A, VAL
+#define POKE32(A, VAL)				.long OP_POKE32, A, VAL
+#define OR8(A, VAL)				.long OP_OR8, A, VAL
+#define OR16(A, VAL)				.long OP_OR16, A, VAL
+#define OR32(A, VAL)				.long OP_OR32, A, VAL
+#define UPDATE8(A, AND, OR)			.long OP_UPDATE8, A, AND, OR
+#define UPDATE16(A, AND, OR)			.long OP_UPDATE16, A, AND, OR
+#define UPDATE32(A, AND, OR)			.long OP_UPDATE32, A, AND, OR
+#define POKE_UPDATE32(A1, A2, AND, SHIFT, OR)	.long OP_POKE_UPDATE32,\
+			 A1, A2, AND, SHIFT, OR
+#define WHILE_NE8(A, AND, VAL)						\
+	.long OP_WHILE_NE8, A, AND, VAL; .if (VAL > 0xFF);		\
+	 ASM_ERROR("Value VAL in WHILE_NE8 should fit in 8 bits"); .endif
+#define WHILE_NE16(A, AND, VAL)				.long OP_WHILE_NE16,\
+		 A, AND, VAL; .if (VAL > 0xFFFF);\
+		 ASM_ERROR("Value VAL in WHILE_NE16 should fit in 16 bits");\
+		 .endif
+#define WHILE_NE32(A, AND, VAL)				.long OP_WHILE_NE32,\
+		 A, AND, VAL
+#define IF_EQ32(NESTLEVEL, A, AND, VAL)					\
+	.long OP_IF_EQ32, A, AND, VAL, (NESTLEVEL ## f - .)
+#define IF_GT32(NESTLEVEL, A, AND, VAL)					\
+	.long OP_IF_GT32, A, AND, VAL, (NESTLEVEL ## f - .)
+/* An explicit ELSE will skip the OP_ELSE embedded in the ENDIF
+ * to make things faster
+ */
+#define ELSE(NESTLEVEL)							\
+	.long OP_ELSE; NESTLEVEL: ; .long (NESTLEVEL ## f - .)
+/* ENDIF includes an OP_ELSE so that we end up at the correct position
+ * regardless of whether there is an explcit ELSE in the IF construct
+ */
+#define ENDIF(NESTLEVEL)						\
+	.long OP_ELSE; NESTLEVEL: ; .long 0
+#define DELAY(ITERATIONS)						\
+	.long OP_DELAY, ITERATIONS
+/* The 2nd argument to the poke loop code (in R5 for ST40, or $r0.17 for ST200)
+ * must be the device ID to compare against for these operations to work - the
+ * poke loop code does not try to retrieve the device ID itself.
+ */
+#define IF_DEVID_GE(NESTLEVEL, VAL)					\
+	.long OP_IF_DEVID_GE, VAL, (NESTLEVEL ## f - .)
+#define IF_DEVID_LE(NESTLEVEL, VAL)					\
+	.long OP_IF_DEVID_LE, VAL, (NESTLEVEL ## f - .)
+/* The end marker needs two extra entries which get read by the code, but are
+   never used.
+ */
+#define END_MARKER							\
+	.long OP_END_POKES
+
+#else
+/* Poke table commands */
+#define POKE8(A, VAL)				OP_POKE8, A, VAL
+#define POKE16(A, VAL)				OP_POKE16, A, VAL
+#define POKE32(A, VAL)				OP_POKE32, A, VAL
+#define OR8(A, VAL)				OP_OR8, A, VAL
+#define OR16(A, VAL)				OP_OR16, A, VAL
+#define OR32(A, VAL)				OP_OR32, A, VAL
+#define UPDATE8(A, AND, OR)			OP_UPDATE8, A, AND, OR
+#define UPDATE16(A, AND, OR)			OP_UPDATE16, A, AND, OR
+#define UPDATE32(A, AND, OR)			OP_UPDATE32, A, AND, OR
+#define POKE_UPDATE32(A1, A2, AND, SHIFT, OR)	\
+		OP_POKE_UPDATE32, A1, A2, AND, SHIFT, OR
+#define WHILE_NE8(A, AND, VAL)			OP_WHILE_NE8, A, AND, VAL
+#define WHILE_NE16(A, AND, VAL)			OP_WHILE_NE16, A, AND, VAL
+#define WHILE_NE32(A, AND, VAL)			OP_WHILE_NE32, A, AND, VAL
+#define IF_EQ32(NESTLEVEL, A, AND, VAL)
+#define IF_GT32(NESTLEVEL, A, AND, VAL)
+#define ELSE(NESTLEVEL)
+#define ENDIF(NESTLEVEL)
+#define DELAY(ITERATIONS)			OP_DELAY, ITERATIONS
+#define IF_DEVID_GE(NESTLEVEL, VAL)
+#define IF_DEVID_LE(NESTLEVEL, VAL)
+#define END_MARKER				OP_END_POKES
+
+#include <linux/suspend.h>
+
+
+#define NO_SLEEP_ON_STANDBY		1
+#define NO_SLEEP_ON_MEMSTANDBY		2
+#define EARLY_ACTION_ON_STANDBY		4
+#define EARLY_ACTION_ON_MEMSTANDBY	8
+
+struct stm_suspend_t {
+	long flags;
+	long stby_tbl;
+	long stby_size;
+	long mem_tbl;
+	long mem_size;
+	int (*evt_to_irq)(unsigned long evt);
+	struct platform_suspend_ops ops;
+};
+
+int stm_suspend_register(struct stm_suspend_t *soc_suspend);
+
+void stm_suspend(unsigned int tbl, unsigned int tbl_end,
+		unsigned long lpj, unsigned int flags);
+#endif
+
+#endif
-- 
1.6.2.5

