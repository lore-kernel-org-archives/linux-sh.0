From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 03 Jan 2017 09:51:45 +0000
Subject: Re: Build regressions/improvements in v4.10-rc2
Message-Id: <CAMuHMdX_sFumc+BRjt-bkAh=dMgS21HQv4eioKaK-q7h1ZDFeg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1483437021-29391-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1483437021-29391-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>

On Tue, Jan 3, 2017 at 10:50 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.10-rc2[1] to v4.10-rc1[3], the summaries are:
>   - build errors: +2/-7242

  + /home/kisskb/slave/src/arch/sh/mm/cache-sh4.c: error:
'cached_to_uncached' undeclared (first use in this function):  =>
99:17
  + /home/kisskb/slave/src/arch/sh/mm/cache-sh4.c: error: implicit
declaration of function 'cpu_context'
[-Werror=implicit-function-declaration]:  => 192:6

sh-randconfig

Not really new, but it never hurts to point it out from time to time ;-)

> [1] http://kisskb.ellerman.id.au/kisskb/head/0c744ea4f77d72b3dcebb7a8f2684633ec79be88/ (all 267 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7ce7d89f48834cefece7804d38fc5d85382edf77/ (all 267 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
