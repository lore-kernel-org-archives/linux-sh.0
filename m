From: Michel Lespinasse <walken@google.com>
Date: Fri, 11 Jan 2013 03:04:32 +0000
Subject: Re: Current SuperH board can't boot
Message-Id: <20130111030432.GA3386@google.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vcb44gaq.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vcb44gaq.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 10, 2013 at 6:14 PM, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:
> Hi Paul, Michel, and all
>
> I noticed that SuperH ecovec board can't boot on latest linus/master branch.
> NFS rootfs can't mount.
> I git-bisect'ed this issue, and found first bad commit.
> Below is bad commit and my kernel log.

Sorry for the trouble. Looking at the commit again and at your logs, I
can't see what's causing this.

Could you please try with CONFIG_DEBUG_VM, CONFIG_DEBUG_VM_RB,
loglevel=8 boot option, and the following patch which I hope may give
us some useful debug information ?

diff --git a/mm/mmap.c b/mm/mmap.c
index 532f447879d4..acc282e26b57 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1557,6 +1557,13 @@ unacct_error:
 	return error;
 }
 
+static void show_vm_unmapped_area_info (struct vm_unmapped_area_info *info)
+{
+	printk("show_vm_unmapped_area_info: %lx %lx [%lx;%lx) %lx %lx\n",
+	       info->flags, info->length, info->low_limit, info->high_limit,
+	       info->align_mask, info->align_offset);
+}
+
 unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
 	/*
@@ -1571,6 +1578,9 @@ unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 	struct vm_area_struct *vma;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
 
+	validate_mm(mm);
+	show_vm_unmapped_area_info(info);
+
 	/* Adjust search length to account for worst case alignment overhead */
 	length = info->length + info->align_mask;
 	if (length < info->length)
@@ -1656,6 +1666,7 @@ found:
 
 	VM_BUG_ON(gap_start + info->length > info->high_limit);
 	VM_BUG_ON(gap_start + info->length > gap_end);
+	printk("unmapped_area: found %lx\n", gap_start);
 	return gap_start;
 }
 
@@ -1665,6 +1676,9 @@ unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 	struct vm_area_struct *vma;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
 
+	validate_mm(mm);
+	show_vm_unmapped_area_info(info);
+
 	/* Adjust search length to account for worst case alignment overhead */
 	length = info->length + info->align_mask;
 	if (length < info->length)
@@ -1754,6 +1768,7 @@ found_highest:
 
 	VM_BUG_ON(gap_end < info->low_limit);
 	VM_BUG_ON(gap_end < gap_start);
+	printk("unmapped_area_topdown: found %lx\n", gap_end);
 	return gap_end;
 }
 
-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
