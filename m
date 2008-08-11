From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 11 Aug 2008 06:13:24 +0000
Subject: [PATCH] sh: select memchunk size using kernel cmdline
Message-Id: <20080811061324.19955.97869.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Allow user to pass parameters on kernel command line to override
default size for physically contiguous memory buffers. The default
VPU buffer size is too small for VGA harware encoding, but instead
of just bumping up the number we allow the user to override the
default size using the command line. Supports SuperH Mobile hardware
blocks such as VEU, VPU and CEU.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/mm/consistent.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- 0001/arch/sh/mm/consistent.c
+++ work/arch/sh/mm/consistent.c	2008-08-11 14:32:08.000000000 +0900
@@ -95,6 +95,29 @@ void dma_cache_sync(struct device *dev, 
 }
 EXPORT_SYMBOL(dma_cache_sync);
 
+static int __init memchunk_setup(char *str)
+{
+	return 1; /* accept anything that begins with "memchunk." */
+}
+__setup("memchunk.", memchunk_setup);
+
+static void memchunk_cmdline_override(char *name, unsigned long *sizep)
+{
+	char *p = boot_command_line;
+	int k = strlen(name);
+
+	while ((p = strstr(p, "memchunk."))) {
+		p += 9; /* strlen("memchunk.") */
+		if (!strncmp(name, p, k) && p[k] = '=') {
+			p += k + 1;
+			*sizep = memparse(p, NULL);
+			pr_info("%s: forcing memory chunk size to 0x%08lx\n",
+				name, *sizep);
+			break;
+		}
+	}
+}
+
 int platform_resource_setup_memory(struct platform_device *pdev,
 				   char *name, unsigned long memsize)
 {
@@ -109,6 +132,10 @@ int platform_resource_setup_memory(struc
 		return -EINVAL;
 	}
 
+	memchunk_cmdline_override(name, &memsize);
+	if (!memsize)
+		return 0;
+
 	buf = dma_alloc_coherent(NULL, memsize, &dma_handle, GFP_KERNEL);
 	if (!buf) {
 		pr_warning("%s: unable to allocate memory\n", name);
