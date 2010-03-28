From: Matt Fleming <matt@console-pimps.org>
Date: Sun, 28 Mar 2010 20:09:08 +0000
Subject: [PATCH] sh: pteaex tlb debugfs support
Message-Id: <5710cd68d399fc83734fcde7116ab91a3cfd624d.1269806831.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Export the status of the utlb and itlb entries through sysfs.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/include/cpu-sh4/cpu/mmu_context.h |    7 ++
 arch/sh/mm/tlb-pteaex.c                   |  144 +++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/mmu_context.h b/arch/sh/include/cpu-sh4/cpu/mmu_context.h
index 5963124..2941be6 100644
--- a/arch/sh/include/cpu-sh4/cpu/mmu_context.h
+++ b/arch/sh/include/cpu-sh4/cpu/mmu_context.h
@@ -19,10 +19,17 @@
 
 #define MMUCR		0xFF000010	/* MMU Control Register */
 
+#define MMU_TLB_ENTRY_SHIFT	8
+
 #define MMU_ITLB_ADDRESS_ARRAY  0xF2000000
 #define MMU_ITLB_ADDRESS_ARRAY2	0xF2800000
+#define MMU_ITLB_DATA_ARRAY	0xF3000000
+#define MMU_ITLB_DATA_ARRAY2	0xF3800000
+
 #define MMU_UTLB_ADDRESS_ARRAY	0xF6000000
 #define MMU_UTLB_ADDRESS_ARRAY2	0xF6800000
+#define MMU_UTLB_DATA_ARRAY	0xF7000000
+#define MMU_UTLB_DATA_ARRAY2	0xF7800000
 #define MMU_PAGE_ASSOC_BIT	0x80
 
 #define MMUCR_TI		(1<<2)
diff --git a/arch/sh/mm/tlb-pteaex.c b/arch/sh/mm/tlb-pteaex.c
index bdd0982..f706576 100644
--- a/arch/sh/mm/tlb-pteaex.c
+++ b/arch/sh/mm/tlb-pteaex.c
@@ -12,6 +12,9 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/io.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/module.h>
 #include <asm/system.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
@@ -77,3 +80,144 @@ void local_flush_tlb_one(unsigned long asid, unsigned long page)
 	__raw_writel(asid, MMU_ITLB_ADDRESS_ARRAY2 | MMU_PAGE_ASSOC_BIT);
 	back_to_cached();
 }
+
+enum tlb_type {
+	TLB_TYPE_ITLB,
+	TLB_TYPE_UTLB,
+};
+
+struct _tlb_size {
+	int bits;
+	const char *size;
+};
+
+static struct _tlb_size tlb_sizes[] = {
+	{ 0x0, "  1KB" },
+	{ 0x1, "  4KB" },
+	{ 0x2, "  8KB" },
+	{ 0x4, " 64KB" },
+	{ 0x5, "256KB" },
+	{ 0x7, "  1MB" },
+	{ 0x8, "  4MB" },
+	{ 0xc, " 64MB" },
+};
+
+static int tlb_seq_show(struct seq_file *file, void *iter)
+{
+	unsigned int tlb_type = (unsigned int)file->private;
+	unsigned long addr1, addr2, data1, data2;
+	unsigned int nentries, entry;
+	unsigned int urb;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	jump_to_uncached();
+
+	urb = __raw_readl(MMUCR);
+	urb = (urb & MMUCR_URB) >> MMUCR_URB_SHIFT;
+
+	/* Make the "entry >= urb" test fail. */
+	if (urb = 0)
+		urb = MMUCR_URB_NENTRIES + 1;
+
+	if (tlb_type = TLB_TYPE_ITLB) {
+		addr1 = MMU_ITLB_ADDRESS_ARRAY;
+		addr2 = MMU_ITLB_ADDRESS_ARRAY2;
+		data1 = MMU_ITLB_DATA_ARRAY;
+		data2 = MMU_ITLB_DATA_ARRAY2;
+		nentries = 4;
+	} else {
+		addr1 = MMU_UTLB_ADDRESS_ARRAY;
+		addr2 = MMU_UTLB_ADDRESS_ARRAY2;
+		data1 = MMU_UTLB_DATA_ARRAY;
+		data2 = MMU_UTLB_DATA_ARRAY2;
+		nentries = 64;
+	}
+
+	seq_printf(file, "entry:     vpn        ppn     asid  size valid wired\n");
+
+	for (entry = 0; entry < nentries; entry++) {
+		unsigned long vpn, ppn, asid, size;
+		unsigned long valid;
+		unsigned long val;
+		const char *sz = "    ?";
+		int i;
+
+		val = __raw_readl(addr1 | (entry << MMU_TLB_ENTRY_SHIFT));
+		ctrl_barrier();
+		vpn = val & 0xfffffc00;
+		valid = val & 0x100;
+
+		val = __raw_readl(addr2 | (entry << MMU_TLB_ENTRY_SHIFT));
+		ctrl_barrier();
+		asid = val & MMU_CONTEXT_ASID_MASK;
+
+		val = __raw_readl(data1 | (entry << MMU_TLB_ENTRY_SHIFT));
+		ctrl_barrier();
+		ppn = (val & 0x0ffffc00) << 4;
+
+		val = __raw_readl(data2 | (entry << MMU_TLB_ENTRY_SHIFT));
+		ctrl_barrier();
+		size = (val & 0xf0) >> 4;
+
+		for (i = 0; i < ARRAY_SIZE(tlb_sizes); i++) {
+			if (tlb_sizes[i].bits = size)
+				break;
+		}
+
+		if (i != ARRAY_SIZE(tlb_sizes))
+			sz = tlb_sizes[i].size;
+
+		seq_printf(file, "%2d:    0x%08lx 0x%08lx %5lu %s   %s     %s\n",
+			   entry, vpn, ppn, asid,
+			   sz, valid ? "V" : "-",
+			   (urb <= entry) ? "W" : "-");
+	}
+
+	back_to_cached();
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static int tlb_debugfs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, tlb_seq_show, inode->i_private);
+}
+
+static const struct file_operations tlb_debugfs_fops = {
+	.owner		= THIS_MODULE,
+	.open		= tlb_debugfs_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init tlb_debugfs_init(void)
+{
+	struct dentry *utlb_dentry, *itlb_dentry;
+
+	utlb_dentry = debugfs_create_file("utlb", S_IRUSR, sh_debugfs_root,
+					    (unsigned int *)TLB_TYPE_UTLB,
+					    &tlb_debugfs_fops);
+	if (!utlb_dentry)
+		return -ENOMEM;
+
+	if (IS_ERR(utlb_dentry))
+		return PTR_ERR(utlb_dentry);
+
+	itlb_dentry = debugfs_create_file("itlb", S_IRUSR, sh_debugfs_root,
+					    (unsigned int *)TLB_TYPE_ITLB,
+					    &tlb_debugfs_fops);
+	if (!itlb_dentry) {
+		debugfs_remove(utlb_dentry);
+		return -ENOMEM;
+	}
+	if (IS_ERR(itlb_dentry)) {
+		debugfs_remove(utlb_dentry);
+		return PTR_ERR(itlb_dentry);
+	}
+
+	return 0;
+}
+module_init(tlb_debugfs_init);
-- 
1.6.4.rc0

