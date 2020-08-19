From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Aug 2020 13:50:11 +0000
Subject: Re: [PATCH 1/1] sh: add support for cmpxchg on u8 and u16 pointers
Message-Id: <CAMuHMdWAeccfEbZ=7MFgR=2SyC_1zRNGXG5G6VL5qY=d0HW37A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdVYeAqLHuW2fjQk7HQbnGJhY7YJcksMddn_6Cp61cd-AQ@mail.gmail.com>
 <C510813DTTYI.1PZXLO9Y2FRLM@atris>
In-Reply-To: <C510813DTTYI.1PZXLO9Y2FRLM@atris>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Beguin <liambeguin@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>

Hi Liam,

On Wed, Aug 19, 2020 at 3:34 PM Liam Beguin <liambeguin@gmail.com> wrote:
> On Wed Aug 19, 2020 at 5:09 AM EDT, Geert Uytterhoeven wrote:
> > On Wed, Aug 19, 2020 at 5:07 AM Liam Beguin <liambeguin@gmail.com>
> > wrote:
> > > The kernel test bot reported[1] that using set_mask_bits on a u8 causes
> > > the following issue on SuperH:
> > >
> > >     >> ERROR: modpost: "__cmpxchg_called_with_bad_pointer" [drivers/phy/ti/phy-tusb1210.ko] undefined!
> > >
> > > Add support for cmpxchg on u8 and u16 pointers.
> > >
> > > [1] https://lore.kernel.org/patchwork/patch/1288894/#1485536
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> > > ---
> > >
> > > Hi,
> > >
> > > This was reported by the kernel test bot on an architecture I can't
> > > really test on. I was only able to make sure the build succeeds, but
> > > nothing more.
> > > This patch is based on the __cmpxchg_u32 impletmentation and seems
> > > incomplete based on the different cmpxchg headers I can find.
> >
> > Indeed. This version is suitable for non-SMP machines only.
> > BTW, it looks like this version can be replaced by the one in
> > asm-generic?
> >
>
> Thanks for your feedback I'll have a look at the asm-generic functions
> and try to use those instead.
>
> > >
> > > Do these function need to be impletmented in each header
> > > simulataneously?
> >
> > Yes, we need them for all variants.
> >
>
> Okay, I'll look into that. Would you recommend a good way to test these
> changes?

That's gonna be harder, I'm afraid.
Who has suitable hardware?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
