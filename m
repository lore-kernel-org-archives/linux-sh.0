From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 12 Sep 2008 10:39:59 +0000
Subject: Re: strace not working with latest git
Message-Id: <20080912103959.GB10594@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <37C9A1F7C45F1F498E9CB8295E7B305C513CBB@em-srv1-kaha.intern.emtrion.de>
In-Reply-To: <37C9A1F7C45F1F498E9CB8295E7B305C513CBB@em-srv1-kaha.intern.emtrion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 12, 2008 at 11:54:48AM +0200, Nylund, Martin wrote:
> > On Thu, Sep 11, 2008 at 04:00:16PM +0200, Nylund, Martin wrote:
> > > diff --git a/arch/sh/kernel/ptrace_32.c 
> > b/arch/sh/kernel/ptrace_32.c 
> > > index 035cb30..950b7e2 100644
> > > --- a/arch/sh/kernel/ptrace_32.c
> > > +++ b/arch/sh/kernel/ptrace_32.c
> > > @@ -107,6 +107,9 @@ long arch_ptrace(struct task_struct 
> > *child, long 
> > > request, long addr, long data)
> > >         struct user * dummy = NULL;
> > >         int ret;
> > > 
> > > +       if(addr<0xff)
> > > +           addr=(addr+0x34);
> > > +
> > >         switch (request) {
> > >         /* read the word at location addr in the USER area. */
> > >         case PTRACE_PEEKUSR: {
> > > 
> > This looks very much like the sizeof struct pt_dspregs. What 
> > is your CONFIG_SH_DSP setting? Have you tried changing it and 
> > comparing?
> 
> Yes I had CONFIG_SH_DSP set. I now switched it off and strace works
> without the above offset hack.

That's interesting. It looks like CONFIG_SH_DSP needs some more attention
for SH4AL-DSP anyways. I'm currently rewriting the ptrace bits for
tracehook/regset conversion anyways, so we should get this fixed properly
there.
