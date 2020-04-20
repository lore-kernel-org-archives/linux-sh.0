From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 20 Apr 2020 15:08:58 +0000
Subject: Re: [PATCH 1/2] sh: remove sh5 support
Message-Id: <CAK8P3a2y4n-jv3eNWW4q__YP=QA7UDuybs4nBwdTuiqWm247Tg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200420123844.3998746-1-arnd@arndb.de> <CAMuHMdUZR9A+nCYL_uUOJt48FQnJTJ9eMwWUuV-Z0UWJZ8SaSA@mail.gmail.com>
In-Reply-To: <CAMuHMdUZR9A+nCYL_uUOJt48FQnJTJ9eMwWUuV-Z0UWJZ8SaSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Magnus Damm <magnus.damm@gmail.com>

On Mon, Apr 20, 2020 at 4:40 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Arnd,
>
> On Mon, Apr 20, 2020 at 2:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > sh5 never became a product and has probably never really worked.
> >
> > Remove it by recursively deleting all associated Kconfig options
> > and all corresponding files.
>
> Thanks a lot!
>
> > For review purposes, this leaves out the files that can now be
> > removed, in particular
> >
> >  arch/sh/drivers/pci/*-sh5.c
> >  arch/sh/include/asm/*_64.h
> >  arch/sh/include/uapi/asm/*_64.h
> >  arch/sh/include/cpu-sh5/*
> >  arch/sh/kernel/cpu/sh5/*
> >  arch/sh/lib64/*
> >  arch/sh/mm/*-sh5.c
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> A few nits below...
>
> > --- a/arch/sh/Kconfig
> > +++ b/arch/sh/Kconfig
> > @@ -62,7 +62,7 @@ config SUPERH
> >           <http://www.linux-sh.org/>.
> >
> >  config SUPERH32
>
> Why keep the SUPERH32 symbol?
> Because you forgot to clean a few files?

It seemed simpler this way, but I can remove it as well.

>     arch/sh/include/asm/bl_bit.h:#ifdef CONFIG_SUPERH32
>     arch/sh/include/asm/cache_insns.h:#ifdef CONFIG_SUPERH32
>     arch/sh/include/asm/checksum.h:#ifdef CONFIG_SUPERH32

Ah, I had removed these at first when I renamed the *_32.h over
those files, but then decided to not do that, to keep the patch
easier to review.

> > --- a/arch/sh/include/asm/vmlinux.lds.h
> > +++ b/arch/sh/include/asm/vmlinux.lds.h
> > @@ -15,12 +15,6 @@
> >  #define DWARF_EH_FRAME
> >  #endif
> >
> > -#ifdef CONFIG_SUPERH64
> > -#define EXTRA_TEXT             \
> > -       *(.text64)              \
> > -       *(.text..SHmedia32)
> > -#else
> >  #define EXTRA_TEXT
> > -#endif
>
> You might remove the empty definition, too, as you removed the sole user...

Right, I planned to remove that one and forgot.

> > --- a/arch/sh/kernel/vmlinux.lds.S
> > +++ b/arch/sh/kernel/vmlinux.lds.S
>
> > @@ -28,14 +21,13 @@ SECTIONS
> >
> >         _text = .;              /* Text and read-only data */
> >
> > -       .empty_zero_page : AT(ADDR(.empty_zero_page) - LOAD_OFFSET) {
> > +       .empty_zero_page : AT(ADDR(.empty_zero_page)) {
> >                 *(.empty_zero_page)
> >         } = 0
> >
> > -       .text : AT(ADDR(.text) - LOAD_OFFSET) {
> > +       .text : AT(ADDR(.text)) {
> >                 HEAD_TEXT
> >                 TEXT_TEXT
> > -               EXTRA_TEXT
>
> ... here.
>
> >                 SCHED_TEXT
> >                 CPUIDLE_TEXT
> >                 LOCK_TEXT
>
> I think at least some of the following should be cleant, too:
>
> arch/sh/include/asm/elf.h:#ifdef __SH5__
> arch/sh/include/uapi/asm/posix_types.h:# ifdef __SH5__
> arch/sh/include/uapi/asm/swab.h:#ifdef __SH5__
> arch/sh/include/uapi/asm/swab.h:#ifdef __SH5__
> arch/sh/include/uapi/asm/unistd.h:# ifdef __SH5__
> tools/arch/sh/include/asm/barrier.h:#if defined(__SH4A__) || defined(__SH5__)

Good catch, thanks!

        Arnd
