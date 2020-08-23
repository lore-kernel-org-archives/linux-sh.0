From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 23 Aug 2020 08:47:36 +0000
Subject: Re: [PATCH 1/1] sh: add support for cmpxchg on u8 and u16 pointers
Message-Id: <CAMuHMdW49JKKqckxsbb1CZxDT8=PDNcVs+e+6ob4aCDQn-QkUg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200819030511.1114-1-liambeguin@gmail.com>
In-Reply-To: <20200819030511.1114-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rob,

On Fri, Aug 21, 2020 at 10:37 PM Rob Landley <rob@landley.net> wrote:
> On 8/19/20 8:50 AM, Geert Uytterhoeven wrote:
> > On Wed, Aug 19, 2020 at 3:34 PM Liam Beguin <liambeguin@gmail.com> wrote:
> >> On Wed Aug 19, 2020 at 5:09 AM EDT, Geert Uytterhoeven wrote:
> >>> On Wed, Aug 19, 2020 at 5:07 AM Liam Beguin <liambeguin@gmail.com>
> >>> wrote:
> >>>> The kernel test bot reported[1] that using set_mask_bits on a u8 causes
> >>>> the following issue on SuperH:
> >>>>
> >>>>     >> ERROR: modpost: "__cmpxchg_called_with_bad_pointer" [drivers/phy/ti/phy-tusb1210.ko] undefined!
> >>>>
> >>>> Add support for cmpxchg on u8 and u16 pointers.
> >>>>
> >>>> [1] https://lore.kernel.org/patchwork/patch/1288894/#1485536
> >>>>
> >>>> Reported-by: kernel test robot <lkp@intel.com>
> >>>> Signed-off-by: Liam Beguin <liambeguin@gmail.com>

> >>>> This was reported by the kernel test bot on an architecture I can't
> >>>> really test on. I was only able to make sure the build succeeds, but
> >>>> nothing more.
> >>>> This patch is based on the __cmpxchg_u32 impletmentation and seems
> >>>> incomplete based on the different cmpxchg headers I can find.
> >>>
> >>> Indeed. This version is suitable for non-SMP machines only.
> >>> BTW, it looks like this version can be replaced by the one in
> >>> asm-generic?
> >>>
> >>
> >> Thanks for your feedback I'll have a look at the asm-generic functions
> >> and try to use those instead.
>
> Does using the asm-generic one automatically use the architecture version for
> j-core? (Technically we're compare-and-swap rather than cmpxchg but eh, close
> enough: CAS.L Rm, Rn, @R0 opcode 0010-nnnn-mmmm-0011, based on the IBM 360
> instruction. Not sure how the #include plumbing winds up selecting the version
> here, if there's an extra thing we have to do we should do it.)

No, the asm-generic is only suitable for arch/sh/include/asm/cmpxchg-irq.h.
There are 3 different implementations needed to cover all, cfr. below.

> >> Okay, I'll look into that. Would you recommend a good way to test these
> >> changes?
> >
> > That's gonna be harder, I'm afraid.
> > Who has suitable hardware?
>
> Define suitable? (Not familiar with testbot? In addition to a raspberry pi form
> factor j-core board that runs off my laptop's usb power pretty much with me at
> all times, I have a johnson controls sh4 board in a box, a little blue board
> that runs an st kernel fork in the same box, and an sh2 board from the dawn of
> time in another box. I generally use the j-core board as my hardware and
> regression test sh4 on qemu unless I'm checking a specific hardware thing.)

arch/sh/include/asm/cmpxchg.h:

    #if defined(CONFIG_GUSA_RB)
    #include <asm/cmpxchg-grb.h>
    #elif defined(CONFIG_CPU_SH4A)
    #include <asm/cmpxchg-llsc.h>
    #elif defined(CONFIG_CPU_J2) && defined(CONFIG_SMP)
    #include <asm/cmpxchg-cas.h>
    #else
    #include <asm/cmpxchg-irq.h>
   #endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
