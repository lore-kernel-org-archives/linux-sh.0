From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 01 Aug 2018 07:27:05 +0000
Subject: Re: Boot time warning in today's git.
Message-Id: <CAMuHMdXA7=hmLPajE4RgMkw9Q9TqWxJafAMMrpZSjHe0XXu56w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rob,

On Tue, Jul 31, 2018 at 7:19 PM Rob Landley <rob@landley.net> wrote:
> My https://github.com/landley/mkroot build (from the attached miniconfig) did:
>
> Freeing unused kernel memory: 116K
> This architecture does not have kernel memory protection.
> WARNING: CPU: 0 PID: 1 at mm/slub.c:2412 ___slab_alloc.constprop.34+0x196/0x288

Same one as "Random warning dump during init."
(https://www.spinics.net/lists/linux-sh/msg53148.html).

Fixed by  "[PATCH] sh: remove unneeded constructor."
(https://www.spinics.net/lists/linux-sh/msg53250.html).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
