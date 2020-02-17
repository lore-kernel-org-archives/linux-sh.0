From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Mon, 17 Feb 2020 09:40:01 +0000
Subject: Re: [PATCH 2/5] mm/vma: Make vma_is_accessible() available for general use
Message-Id: <1d28a706-3232-2660-f2f2-2faca999a3ff@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1581915833-21984-1-git-send-email-anshuman.khandual@arm.com>
 <1581915833-21984-3-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1581915833-21984-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Guo Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org


On 02/17/2020 10:33 AM, Anshuman Khandual wrote:
> Lets move vma_is_accessible() helper to include/linux/mm.h which makes it
> available for general use. While here, this replaces all remaining open
> encodings for VMA access check with vma_is_accessible().
> 
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-sh@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/csky/mm/fault.c    | 2 +-
>  arch/m68k/mm/fault.c    | 2 +-
>  arch/mips/mm/fault.c    | 2 +-
>  arch/powerpc/mm/fault.c | 2 +-
>  arch/sh/mm/fault.c      | 2 +-
>  arch/x86/mm/fault.c     | 2 +-
>  include/linux/mm.h      | 5 +++++
>  kernel/sched/fair.c     | 2 +-
>  mm/gup.c                | 2 +-
>  mm/memory.c             | 5 -----
>  mm/mempolicy.c          | 3 +--
>  11 files changed, 14 insertions(+), 15 deletions(-)

There are couple of places in mm/mmap.c which could use vma_is_accessible()
as well. Probably missed them, as the order of the VMA flags were different.
Will fold the following changes next time around.

diff --git a/mm/mmap.c b/mm/mmap.c
index 6756b8bb0033..9b9bb4031fd4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2338,8 +2338,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
                gap_addr = TASK_SIZE;
 
        next = vma->vm_next;
-       if (next && next->vm_start < gap_addr &&
-                       (next->vm_flags & (VM_WRITE|VM_READ|VM_EXEC))) {
+       if (next && next->vm_start < gap_addr && vma_is_accessible(next)) {
                if (!(next->vm_flags & VM_GROWSUP))
                        return -ENOMEM;
                /* Check that both stack segments have the same anon_vma? */
@@ -2420,7 +2419,7 @@ int expand_downwards(struct vm_area_struct *vma,
        prev = vma->vm_prev;
        /* Check that both stack segments have the same anon_vma? */
        if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
-                       (prev->vm_flags & (VM_WRITE|VM_READ|VM_EXEC))) {
+                       vma_is_accessible(prev)) {
                if (address - prev->vm_end < stack_guard_gap)
                        return -ENOMEM;
        }
