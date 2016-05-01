From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 01 May 2016 05:08:29 +0000
Subject: [PATCH RESEND 05/12] sh: DeviceTree support update
Message-Id: <1462079316-27771-6-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1462079316-27771-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1462079316-27771-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Changes bellow
- FDT setup timing fix.
- chosen/bootargs support.
- zImage support.
- DT binding helper macro.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boards/of-generic.c                        | 23 +++++++++++-----------
 arch/sh/boot/compressed/head_32.S                  |  5 +++--
 arch/sh/boot/dts/include/dt-bindings               |  1 +
 arch/sh/kernel/setup.c                             | 19 ++++++++++++++++++
 include/dt-bindings/interrupt-controller/sh_intc.h |  2 ++
 5 files changed, 36 insertions(+), 14 deletions(-)
 create mode 120000 arch/sh/boot/dts/include/dt-bindings
 create mode 100644 include/dt-bindings/interrupt-controller/sh_intc.h

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index bf3a166..9570873 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -112,29 +112,25 @@ static int noopi(void)
 	return 0;
 }
 
-static void __init sh_of_mem_reserve(void)
+static void __init sh_of_mem_init(void)
 {
 	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
 }
 
-static void __init sh_of_time_init(void)
-{
-	pr_info("SH generic board support: scanning for clocksource devices\n");
-	clocksource_probe();
-}
-
 static void __init sh_of_setup(char **cmdline_p)
 {
-	unflatten_device_tree();
-
-	board_time_init = sh_of_time_init;
+	struct device_node *cpu;
+	int freq;
 
 	sh_mv.mv_name = of_flat_dt_get_machine_name();
 	if (!sh_mv.mv_name)
 		sh_mv.mv_name = "Unknown SH model";
 
 	sh_of_smp_probe();
+	cpu = of_find_node_by_name(NULL, "cpu");
+	if (!of_property_read_u32(cpu, "clock-frequency", &freq))
+		preset_lpj = freq / 500;
 }
 
 static int sh_of_irq_demux(int irq)
@@ -167,8 +163,7 @@ static struct sh_machine_vector __initmv sh_of_generic_mv = {
 	.mv_init_irq	= sh_of_init_irq,
 	.mv_clk_init	= sh_of_clk_init,
 	.mv_mode_pins	= noopi,
-	.mv_mem_init	= noop,
-	.mv_mem_reserve	= sh_of_mem_reserve,
+	.mv_mem_init	= sh_of_mem_init,
 };
 
 struct sh_clk_ops;
@@ -194,3 +189,7 @@ static int __init sh_of_device_init(void)
 	return 0;
 }
 arch_initcall_sync(sh_of_device_init);
+
+void intc_finalize(void)
+{
+}
diff --git a/arch/sh/boot/compressed/head_32.S b/arch/sh/boot/compressed/head_32.S
index 3e15032..cd34377 100644
--- a/arch/sh/boot/compressed/head_32.S
+++ b/arch/sh/boot/compressed/head_32.S
@@ -14,7 +14,8 @@ startup:
 	/* Load initial status register */
 	mov.l   init_sr, r1
 	ldc     r1, sr
-
+	/* Save FDT address */
+	mov	r4, r13
 	/* Move myself to proper location if necessary */
 	mova	1f, r0
 	mov.l	1f, r2
@@ -83,7 +84,7 @@ l1:
 	/* Jump to the start of the decompressed kernel */
 	mov.l	kernel_start_addr, r0
 	jmp	@r0
-	nop
+	  mov	r13,r4
 	
 	.align	2
 bss_start_addr:
diff --git a/arch/sh/boot/dts/include/dt-bindings b/arch/sh/boot/dts/include/dt-bindings
new file mode 120000
index 0000000..08c00e4
--- /dev/null
+++ b/arch/sh/boot/dts/include/dt-bindings
@@ -0,0 +1 @@
+../../../../../include/dt-bindings
\ No newline at end of file
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 5d34605..f6bb105 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -177,7 +177,12 @@ disable:
 #ifndef CONFIG_GENERIC_CALIBRATE_DELAY
 void calibrate_delay(void)
 {
+#ifndef CONFIG_OF
 	struct clk *clk = clk_get(NULL, "cpu_clk");
+#else
+	struct device_node *cpu = of_find_node_by_name(NULL, "cpu");
+	struct clk *clk = of_clk_get_by_name(cpu, NULL);
+#endif
 
 	if (IS_ERR(clk))
 		panic("Need a sane CPU clock definition!");
@@ -251,7 +256,11 @@ void __ref sh_fdt_init(phys_addr_t dt_phys)
 	/* Avoid calling an __init function on secondary cpus. */
 	if (done) return;
 
+#ifdef CONFIG_USE_BUILTIN_DTB
+	dt_virt = __dtb_start;
+#else
 	dt_virt = phys_to_virt(dt_phys);
+#endif
 
 	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
 		pr_crit("Error: invalid device tree blob"
@@ -267,8 +276,13 @@ void __ref sh_fdt_init(phys_addr_t dt_phys)
 
 void __init setup_arch(char **cmdline_p)
 {
+#ifdef CONFIG_OF
+	unflatten_device_tree();
+#endif
 	enable_mmu();
 
+
+#ifndef CONFIG_OF
 	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
 
 	printk(KERN_NOTICE "Boot params:\n"
@@ -290,6 +304,7 @@ void __init setup_arch(char **cmdline_p)
 
 	if (!MOUNT_ROOT_RDONLY)
 		root_mountflags &= ~MS_RDONLY;
+#endif
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code = (unsigned long) _etext;
 	init_mm.end_data = (unsigned long) _edata;
@@ -312,9 +327,13 @@ void __init setup_arch(char **cmdline_p)
 #endif
 #endif
 
+#if !defined(CONFIG_OF) || defined(USE_BUILTIN_DTB)
 	/* Save unparsed command line copy for /proc/cmdline */
 	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
+#else
+	*cmdline_p = boot_command_line;
+#endif
 
 	parse_early_param();
 
diff --git a/include/dt-bindings/interrupt-controller/sh_intc.h b/include/dt-bindings/interrupt-controller/sh_intc.h
new file mode 100644
index 0000000..8c9dcdc
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/sh_intc.h
@@ -0,0 +1,2 @@
+#define evt2irq(evt)		(((evt) >> 5) - 16)
+#define irq2evt(irq)		(((irq) + 16) << 5)
-- 
2.7.0

