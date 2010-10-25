From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 25 Oct 2010 06:14:57 +0000
Subject: Re: [RFC/PATCH] sh: Add 32bit cou mode to cpu_flags
Message-Id: <20101025061456.GA14778@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1287452609-14530-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1287452609-14530-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 20, 2010 at 11:13:09AM +0900, Nobuhiro Iwamatsu wrote:
> 2010/10/19 Paul Mundt <lethal@linux-sh.org>:
> > On Tue, Oct 19, 2010 at 10:43:29AM +0900, Nobuhiro Iwamatsu wrote:
> >> There is not method to confirm which of 32bit mode or 29bit mode Linux
> >> kernel works.
> >> This patch adds a mode to cpu_flags and can confirm it from auxv and proc
> >> filesystem.
> >>
> > Is there some use you had in mind for this?
> 
> First , I wanted these as information simply.
> 
> And I am debuging kexec-toos for 32bit mode.
> I need this information to use as __pa in kernel.
> If there is a good method, please teach it.
> 
While I agree that having this information exposed is useful, I don't
think it really falls under a CPU capability as such. 32-bit capable CPUs
can be either in 29 or 32-bit physical mode, so the existence of the PMB
is not sufficient for determining configuration.

The x86 approach for reporting the physical address space size seems like
a pretty good fit for this though, so how about this instead?

---

diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index 0a58cb2..c9e7cbc 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -89,6 +89,7 @@ struct sh_cpuinfo {
 	struct task_struct *idle;
 #endif
 
+	unsigned int phys_bits;
 	unsigned long flags;
 } __attribute__ ((aligned(L1_CACHE_BYTES)));
 
diff --git a/arch/sh/kernel/cpu/init.c b/arch/sh/kernel/cpu/init.c
index 9766106..fac742e 100644
--- a/arch/sh/kernel/cpu/init.c
+++ b/arch/sh/kernel/cpu/init.c
@@ -340,6 +340,8 @@ asmlinkage void __cpuinit cpu_init(void)
 	 */
 	current_cpu_data.asid_cache = NO_CONTEXT;
 
+	current_cpu_data.phys_bits = __in_29bit_mode() ? 29 : 32;
+
 	speculative_execution_init();
 	expmask_init();
 
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 4e27846..0af25e0 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -432,6 +432,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	if (c->flags & CPU_HAS_L2_CACHE)
 		show_cacheinfo(m, "scache", c->scache);
 
+	seq_printf(m, "address sizes\t: %u bits physical\n", c->phys_bits);
+
 	seq_printf(m, "bogomips\t: %lu.%02lu\n",
 		     c->loops_per_jiffy/(500000/HZ),
 		     (c->loops_per_jiffy/(5000/HZ)) % 100);
