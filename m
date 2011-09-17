From: Simon Horman <horms@verge.net.au>
Date: Sat, 17 Sep 2011 08:11:36 +0000
Subject: Re: [RFC] sh: Take into account the base of physical memory in
Message-Id: <20110917081129.GB22218@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1316085179-4207-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1316085179-4207-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Fri, Sep 16, 2011 at 07:59:21PM +0900, Magnus Damm wrote:
> On Thu, Sep 15, 2011 at 8:12 PM, Simon Horman <horms@verge.net.au> wrote:
> > Previously virt_to_phys() assumed that physical memory always started
> > at address 0. This is not always the case.
> 
> I think most boards have NOR Flash or ROM mapped at physical address 0.
> 
> For more information please have a look at: arch/sh/boards/mach-ecovec24/setup.c
> 
> > --- a/kexec/arch/sh/kexec-sh.c
> > +++ b/kexec/arch/sh/kexec-sh.c
> > @@ -188,10 +188,18 @@ void kexec_sh_setup_zero_page(char *zero_page_buf, size_t zero_page_size,
> >  unsigned long virt_to_phys(unsigned long addr)
> >  {
> >        unsigned long seg = addr & 0xe0000000;
> > +       unsigned long long start, end;
> > +       int ret;
> > +
> > +       /* Assume there is only one "System RAM" region */
> > +       ret = parse_iomem_single("System RAM\n", &start, &end);
> > +       if (ret)
> > +               die("Could not parse System RAM region in /proc/iomem\n");
> > +
> >        if (seg != 0x80000000 && seg != 0xc0000000)
> >                die("Virtual address %p is not in P1 or P2\n", (void *)addr);
> >
> > -       return addr - seg;
> > +       return addr - seg + start;
> >  }
> 
> This will most likely also change how 29-bit platforms translate their
> addresses, not sure if that's what you want to do.

I am also unsure about the 29bit case. Do you have any thoughts on
what a good approach might look like?

