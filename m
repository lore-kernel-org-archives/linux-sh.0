From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Fri, 27 Nov 2009 06:42:16 +0000
Subject: [PATCH] sh: convert /proc/cpu/aligmnent,
Message-Id: <20091127064216.GD25983@x200.malnet.ru>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/sh/kernel/traps_32.c |   77 ++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 46 deletions(-)

--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -25,6 +25,7 @@
 #include <linux/kexec.h>
 #include <linux/limits.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/sysfs.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -68,61 +69,49 @@ static const char *se_usermode_action[] = {
 	"signal+warn"
 };
 
-static int
-proc_alignment_read(char *page, char **start, off_t off, int count, int *eof,
-		    void *data)
+static int alignment_proc_show(struct seq_file *m, void *v)
 {
-	char *p = page;
-	int len;
-
-	p += sprintf(p, "User:\t\t%lu\n", se_user);
-	p += sprintf(p, "System:\t\t%lu\n", se_sys);
-	p += sprintf(p, "Half:\t\t%lu\n", se_half);
-	p += sprintf(p, "Word:\t\t%lu\n", se_word);
-	p += sprintf(p, "DWord:\t\t%lu\n", se_dword);
-	p += sprintf(p, "Multi:\t\t%lu\n", se_multi);
-	p += sprintf(p, "User faults:\t%i (%s)\n", se_usermode,
+	seq_printf(m, "User:\t\t%lu\n", se_user);
+	seq_printf(m, "System:\t\t%lu\n", se_sys);
+	seq_printf(m, "Half:\t\t%lu\n", se_half);
+	seq_printf(m, "Word:\t\t%lu\n", se_word);
+	seq_printf(m, "DWord:\t\t%lu\n", se_dword);
+	seq_printf(m, "Multi:\t\t%lu\n", se_multi);
+	seq_printf(m, "User faults:\t%i (%s)\n", se_usermode,
 			se_usermode_action[se_usermode]);
-	p += sprintf(p, "Kernel faults:\t%i (fixup%s)\n", se_kernmode_warn,
+	seq_printf(m, "Kernel faults:\t%i (fixup%s)\n", se_kernmode_warn,
 			se_kernmode_warn ? "+warn" : "");
-
-	len = (p - page) - off;
-	if (len < 0)
-		len = 0;
-
-	*eof = (len <= count) ? 1 : 0;
-	*start = page + off;
-
-	return len;
+	return 0;
 }
 
-static int proc_alignment_write(struct file *file, const char __user *buffer,
-				unsigned long count, void *data)
+static int alignment_proc_open(struct inode *inode, struct file *file)
 {
-	char mode;
-
-	if (count > 0) {
-		if (get_user(mode, buffer))
-			return -EFAULT;
-		if (mode >= '0' && mode <= '5')
-			se_usermode = mode - '0';
-	}
-	return count;
+	return single_open(file, alignment_proc_show, NULL);
 }
 
-static int proc_alignment_kern_write(struct file *file, const char __user *buffer,
-				     unsigned long count, void *data)
+static ssize_t alignment_proc_write(struct file *file,
+		const char __user *buffer, size_t count, loff_t *pos)
 {
+	int *data = PDE(file->f_path.dentry->d_inode)->data;
 	char mode;
 
 	if (count > 0) {
 		if (get_user(mode, buffer))
 			return -EFAULT;
-		if (mode >= '0' && mode <= '1')
-			se_kernmode_warn = mode - '0';
+		if (mode >= '0' && mode <= '5')
+			*data = mode - '0';
 	}
 	return count;
 }
+
+static const struct file_operations alignment_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= alignment_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= alignment_proc_write,
+};
 #endif
 
 static void dump_mem(const char *str, unsigned long bottom, unsigned long top)
@@ -1011,20 +1000,16 @@ static int __init alignment_init(void)
 	if (!dir)
 		return -ENOMEM;
 
-	res = create_proc_entry("alignment", S_IWUSR | S_IRUGO, dir);
+	res = proc_create_data("alignment", S_IWUSR | S_IRUGO, dir,
+			       &alignment_proc_fops, &se_usermode);
 	if (!res)
 		return -ENOMEM;
 
-	res->read_proc = proc_alignment_read;
-	res->write_proc = proc_alignment_write;
-
-        res = create_proc_entry("kernel_alignment", S_IWUSR | S_IRUGO, dir);
+        res = proc_create_data("kernel_alignment", S_IWUSR | S_IRUGO, dir,
+			       &alignment_proc_fops, &se_kernmode_warn);
         if (!res)
                 return -ENOMEM;
 
-        res->read_proc = proc_alignment_read;
-        res->write_proc = proc_alignment_kern_write;
-
 	return 0;
 }
 
