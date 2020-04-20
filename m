From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Apr 2020 14:42:32 +0000
Subject: Re: [PATCH 1/2] sh: remove sh5 support
Message-Id: <CAMuHMdUWZ9SG_x_tEctMUTDt754kOATDTJbem0Ai-94EO8c0ZA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200420123844.3998746-1-arnd@arndb.de> <CAMuHMdUZR9A+nCYL_uUOJt48FQnJTJ9eMwWUuV-Z0UWJZ8SaSA@mail.gmail.com>
In-Reply-To: <CAMuHMdUZR9A+nCYL_uUOJt48FQnJTJ9eMwWUuV-Z0UWJZ8SaSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Magnus Damm <magnus.damm@gmail.com>

Hi Arnd,

On Mon, Apr 20, 2020 at 4:40 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
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

And you forgot to remove the tlbex_64 stuff from arch/sh/mm/Makefile.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
