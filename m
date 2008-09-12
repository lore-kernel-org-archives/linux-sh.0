From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 12 Sep 2008 09:35:14 +0000
Subject: Re: strace not working with latest git
Message-Id: <20080912093514.GA10594@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <37C9A1F7C45F1F498E9CB8295E7B305C513CBB@em-srv1-kaha.intern.emtrion.de>
In-Reply-To: <37C9A1F7C45F1F498E9CB8295E7B305C513CBB@em-srv1-kaha.intern.emtrion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 11, 2008 at 04:00:16PM +0200, Nylund, Martin wrote:
> 
> > I haven't bee able to get strace working on my sh7722 target:
> > 
> > $> uname -a
> > Linux 192.168.105.52 2.6.27-rc6-00008-g3ed6d13-dirty #184 Wed 
> > Sep 10 17:31:44 CEST 2008 sh4al-dsp unknown
> > 
> > $> strace ls
> > restart_syscall(<... resuming interrupted call ...>) = 0
> > .
> > . <repeating many times>
> > .
> > restart_syscall(<... resuming interrupted call ...>) = 0 
> > restart_syscall(<... resuming interrupted call ...>) = 0
> > bin      etc      linuxrc  mplayer  sbin     tmp
> > restart_syscall(<... resuming interrupted call ...>) = 0
> > boot     include  man      opt      share    usr
> > restart_syscall(<... resuming interrupted call ...>) = 0
> > dev      lib      mnt      proc     sys      var
> > restart_syscall(<... resuming interrupted call ...>) = 0
> > ~ #                            
> > 
> > 
> > I traced the problem a bit and in strace sources, the ptrace 
> > call PTRACE_PEEKUSR always returns 0 when fetching the 
> > syscall number. I also added a printk to PTRACE_PEEKUSR in 
> > arch/sh/kernel/ptrace_32.c and the returned value is always 0. 
> > 
> 
> I got strace now working with following hack. Still don't know why this
> is needed though. get_stack_long() seemst to read data from wrong
> offset...
> 
> diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
> index 035cb30..950b7e2 100644
> --- a/arch/sh/kernel/ptrace_32.c
> +++ b/arch/sh/kernel/ptrace_32.c
> @@ -107,6 +107,9 @@ long arch_ptrace(struct task_struct *child, long
> request, long addr, long data)
>         struct user * dummy = NULL;
>         int ret;
> 
> +       if(addr<0xff)
> +           addr=(addr+0x34);
> +
>         switch (request) {
>         /* read the word at location addr in the USER area. */
>         case PTRACE_PEEKUSR: {
> 
This looks very much like the sizeof struct pt_dspregs. What is your
CONFIG_SH_DSP setting? Have you tried changing it and comparing?
