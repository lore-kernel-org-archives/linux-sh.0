From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Feb 2015 01:42:16 +0000
Subject: [PATCH 01/03] ARM: shmobile: Hack x86_64 to enable OF by default
Message-Id: <20150219014216.1795.43121.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Select OF on x86_64 by default to allow building the OF portion
of the R-Car DU driver on a 64-bit architecture.

Not for upstream merge.

Not-yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/x86/Kconfig             |    1 +
 arch/x86/kernel/devicetree.c |    2 ++
 2 files changed, 3 insertions(+)

--- 0001/arch/x86/Kconfig
+++ work/arch/x86/Kconfig	2015-02-19 06:07:13.605531666 +0900
@@ -138,6 +138,7 @@ config X86
 	select HAVE_ACPI_APEI_NMI if ACPI
 	select ACPI_LEGACY_TABLES_LOOKUP if ACPI
 	select X86_FEATURE_NAMES if PROC_FS
+	select OF
 
 config INSTRUCTION_DECODER
 	def_bool y
--- 0001/arch/x86/kernel/devicetree.c
+++ work/arch/x86/kernel/devicetree.c	2015-02-19 06:22:34.375528357 +0900
@@ -150,11 +150,13 @@ static void __init dtb_lapic_setup(void)
 	if (WARN_ON(ret))
 		return;
 
+#ifdef CONFIG_X86_32
 	/* Did the boot loader setup the local APIC ? */
 	if (!cpu_has_apic) {
 		if (apic_force_enable(r.start))
 			return;
 	}
+#endif
 	smp_found_config = 1;
 	pic_mode = 1;
 	register_lapic_address(r.start);
