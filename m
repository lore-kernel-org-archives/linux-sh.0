From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Apr 2020 14:46:15 +0000
Subject: Re: [PATCH 1/2] sh: remove sh5 support
Message-Id: <CAMuHMdUJp4m-wifSgLXmRJ5Zqmsiw++VtkK7LY1FHhtnbrbGFg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200420123844.3998746-1-arnd@arndb.de> <CAMuHMdUZR9A+nCYL_uUOJt48FQnJTJ9eMwWUuV-Z0UWJZ8SaSA@mail.gmail.com>
 <CAMuHMdUWZ9SG_x_tEctMUTDt754kOATDTJbem0Ai-94EO8c0ZA@mail.gmail.com>
In-Reply-To: <CAMuHMdUWZ9SG_x_tEctMUTDt754kOATDTJbem0Ai-94EO8c0ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Magnus Damm <magnus.damm@gmail.com>

Hi Arnd,

On Mon, Apr 20, 2020 at 4:42 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Apr 20, 2020 at 4:40 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Apr 20, 2020 at 2:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > sh5 never became a product and has probably never really worked.
> > >
> > > Remove it by recursively deleting all associated Kconfig options
> > > and all corresponding files.

And all the remaining BITS stuff:

arch/sh/Makefile:BITS                   := 32
arch/sh/Makefile:export ld-bfd BITS
arch/sh/Makefile:head-y := arch/sh/kernel/head_$(BITS).o
arch/sh/boot/compressed/Makefile:                  head_$(BITS).o misc.o piggy.o
arch/sh/boot/compressed/Makefile:OBJECTS = $(obj)/head_$(BITS).o
$(obj)/misc.o $(obj)/cache.o
arch/sh/boot/compressed/Makefile:ifeq ($(BITS),64)
arch/sh/boot/compressed/Makefile:       lib1funcs-dir   := $(addsuffix
$(BITS), $(lib1funcs-dir))
arch/sh/mm/Makefile:mmu-$(CONFIG_MMU)   := extable_$(BITS).o fault.o
ioremap.o kmap.o \
arch/sh/mm/Makefile:                       pgtable.o tlbex_$(BITS).o
tlbflush_$(BITS).o

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
