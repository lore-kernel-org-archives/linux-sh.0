From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Mon, 13 Jun 2016 13:18:20 +0000
Subject: Re: [PATCH] sh: system call wire up
Message-Id: <87lh29dy77.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1465664789-3976-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465664789-3976-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, 12 Jun 2016 20:03:08 +0900,
Sergei Shtylyov wrote:
> 
> Hello.
> 
> On 6/11/2016 8:06 PM, Yoshinori Sato wrote:
> 
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> 
> [...]
> >  #endif /* __ASM_SH_UNISTD_64_H */
> > diff --git a/arch/sh/kernel/syscalls_32.S b/arch/sh/kernel/syscalls_32.S
> > index 734234b..f03a16b 100644
> > --- a/arch/sh/kernel/syscalls_32.S
> > +++ b/arch/sh/kernel/syscalls_32.S
> > @@ -386,3 +386,17 @@ ENTRY(sys_call_table)
> >  	.long sys_process_vm_writev
> >  	.long sys_kcmp
> >  	.long sys_finit_module
> > +	.long sys_sched_getattr
> > +	.long sys_sched_getattr		/* 370 */
> 
>    Not sys_sched_setattr?

Ouch.
Yes. I mistake.
I will send v2.

> > +	.long sys_renameat2
> > +	.long sys_seccomp
> > +	.long sys_getrandom
> > +	.long sys_memfd_create
> > +	.long sys_bpf			/* 375 */
> > +	.long sys_execveat
> > +	.long sys_userfaultfd
> > +	.long sys_membarrier
> > +	.long sys_mlock2
> > +	.long sys_copy_file_range	/* 380 */
> > +	.long sys_preadv2
> > +	.long sys_pwritev2
> > diff --git a/arch/sh/kernel/syscalls_64.S b/arch/sh/kernel/syscalls_64.S
> > index 579fcb9..7e79252 100644
> > --- a/arch/sh/kernel/syscalls_64.S
> > +++ b/arch/sh/kernel/syscalls_64.S
> > @@ -406,3 +406,17 @@ sys_call_table:
> >  	.long sys_process_vm_writev
> >  	.long sys_kcmp
> >  	.long sys_finit_module
> > +	.long sys_sched_getattr		/* 380 */
> > +	.long sys_sched_getattr
> 
>    Not sys_sched_setattr?
> 
> > +	.long sys_renameat2
> > +	.long sys_seccomp
> > +	.long sys_getrandom
> > +	.long sys_memfd_create		/* 385 */
> > +	.long sys_bpf
> > +	.long sys_execveat
> > +	.long sys_userfaultfd
> > +	.long sys_membarrier
> > +	.long sys_mlock2		/* 390 */
> > +	.long sys_copy_file_range
> > +	.long sys_preadv2
> > +	.long sys_pwritev2
> 
> MBR, Serei
> 

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
