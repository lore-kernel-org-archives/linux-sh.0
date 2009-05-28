From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 May 2009 11:51:51 +0000
Subject: [PATCH] sh: boot word / mode pin support V2
Message-Id: <20090528115151.5727.58043.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20090521071620.12842.12995.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090521071620.12842.12995.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add mode pin support for the SuperH architecture V2.

With this patch applied the board code can add their
own function to export the cpu mode pin configuration.
In most cases this will be a constant bitmap, but
boards that allow reading this from a register can
instead read out the pin state from hardware.

The code warns if a pin is tested but no board specific
mode pin function has been provided.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/machvec.h   |    1 +
 arch/sh/include/asm/processor.h |    4 ++++
 arch/sh/kernel/machvec.c        |    1 +
 arch/sh/kernel/setup.c          |   12 ++++++++++++
 4 files changed, 18 insertions(+)

--- 0001/arch/sh/include/asm/machvec.h
+++ work/arch/sh/include/asm/machvec.h	2009-05-28 15:55:02.000000000 +0900
@@ -48,6 +48,7 @@ struct sh_machine_vector {
 	void (*mv_ioport_unmap)(void __iomem *);
 
 	int (*mv_clk_init)(void);
+	int (*mv_mode_pins)(void);
 };
 
 extern struct sh_machine_vector sh_mv;
--- 0001/arch/sh/include/asm/processor.h
+++ work/arch/sh/include/asm/processor.h	2009-05-28 16:00:33.000000000 +0900
@@ -94,6 +94,10 @@ extern struct pt_regs fake_swapper_regs;
 const char *get_cpu_subtype(struct sh_cpuinfo *c);
 extern const struct seq_operations cpuinfo_op;
 
+/* processor boot mode configuration */
+int generic_mode_pins(void);
+int test_mode_pin(int pin);
+
 #ifdef CONFIG_VSYSCALL
 int vsyscall_init(void);
 #else
--- 0001/arch/sh/kernel/machvec.c
+++ work/arch/sh/kernel/machvec.c	2009-05-28 15:55:02.000000000 +0900
@@ -129,6 +129,7 @@ void __init sh_mv_setup(void)
 	mv_set(ioport_map);
 	mv_set(ioport_unmap);
 	mv_set(irq_demux);
+	mv_set(mode_pins);
 
 	if (!sh_mv.mv_nr_irqs)
 		sh_mv.mv_nr_irqs = NR_IRQS;
--- 0001/arch/sh/kernel/setup.c
+++ work/arch/sh/kernel/setup.c	2009-05-28 16:00:35.000000000 +0900
@@ -420,6 +420,18 @@ void __init setup_arch(char **cmdline_p)
 #endif
 }
 
+/* processor boot mode configuration */
+int generic_mode_pins(void)
+{
+	pr_warning("generic_mode_pins(): missing mode pin configuration\n");
+	return 0;
+}
+
+int test_mode_pin(int pin)
+{
+	return sh_mv.mv_mode_pins() & (1 << pin);
+}
+
 static const char *cpu_name[] = {
 	[CPU_SH7201]	= "SH7201",
 	[CPU_SH7203]	= "SH7203",	[CPU_SH7263]	= "SH7263",
