From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 23 Apr 2008 11:50:27 +0000
Subject: [PATCH] sh: add kernel bss resource
Message-Id: <20080423115027.3892.96459.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Do like everyone else and have a struct resource for kernel bss.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/setup.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- 0001/arch/sh/kernel/setup.c
+++ work/arch/sh/kernel/setup.c	2008-04-22 17:27:47.000000000 +0900
@@ -76,6 +76,11 @@ static struct resource data_resource = {
 	.flags = IORESOURCE_BUSY | IORESOURCE_MEM,
 };
 
+static struct resource bss_resource = {
+	.name	= "Kernel bss",
+	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM,
+};
+
 unsigned long memory_start;
 EXPORT_SYMBOL(memory_start);
 unsigned long memory_end = 0;
@@ -267,6 +272,8 @@ void __init setup_arch(char **cmdline_p)
 	code_resource.end = virt_to_phys(_etext)-1;
 	data_resource.start = virt_to_phys(_etext);
 	data_resource.end = virt_to_phys(_edata)-1;
+	bss_resource.start = virt_to_phys(__bss_start);
+	bss_resource.end = virt_to_phys(_ebss)-1;
 
 	memory_start = (unsigned long)__va(__MEMORY_START);
 	if (!memory_end)
