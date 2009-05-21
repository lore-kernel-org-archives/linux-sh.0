From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 21 May 2009 07:16:20 +0000
Subject: [PATCH] sh: boot word / mode pin support
Message-Id: <20090521071620.12842.12995.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add mode pin support for the SuperH architecture.

Processor and board specific code can with this patch
use set_mode_pin() to set mode pin configuration. Use
test_mode_pin() to test already set mode pin values.

The code warns if a pin is tested but not configured.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/processor.h |    4 ++++
 arch/sh/kernel/setup.c          |   28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

--- 0001/arch/sh/include/asm/processor.h
+++ work/arch/sh/include/asm/processor.h	2009-05-21 15:57:36.000000000 +0900
@@ -94,6 +94,10 @@ extern struct pt_regs fake_swapper_regs;
 const char *get_cpu_subtype(struct sh_cpuinfo *c);
 extern const struct seq_operations cpuinfo_op;
 
+#define SH_MODE_PINS_NR 16
+void set_mode_pin(int pin, int on);
+int test_mode_pin(int pin);
+
 #ifdef CONFIG_VSYSCALL
 int vsyscall_init(void);
 #else
--- 0001/arch/sh/kernel/setup.c
+++ work/arch/sh/kernel/setup.c	2009-05-21 16:08:18.000000000 +0900
@@ -420,6 +420,34 @@ void __init setup_arch(char **cmdline_p)
 #endif
 }
 
+/* processor boot mode configuration */
+static DECLARE_BITMAP(mode_pins, SH_MODE_PINS_NR * 2);
+
+void set_mode_pin(int pin, int on)
+{
+	BUG_ON(pin >= SH_MODE_PINS_NR);
+
+	/* mark pin as configured */
+	set_bit(pin + SH_MODE_PINS_NR, mode_pins);
+
+	/* remember pin value */
+	if (on)
+		set_bit(pin, mode_pins);
+	else
+		clear_bit(pin, mode_pins);
+}
+
+int test_mode_pin(int pin)
+{
+	BUG_ON(pin >= SH_MODE_PINS_NR);
+
+	/* warn if not configured */
+	if (!test_bit(pin + SH_MODE_PINS_NR, mode_pins))
+		pr_warning("test_mode_pin(): pin %d not configured\n", pin);
+
+	return test_bit(pin, mode_pins);
+}
+
 static const char *cpu_name[] = {
 	[CPU_SH7201]	= "SH7201",
 	[CPU_SH7203]	= "SH7203",	[CPU_SH7263]	= "SH7263",
