From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 16 Jul 2017 18:28:19 +0000
Subject: Re: Build regressions/improvements in v4.13-rc1
Message-Id: <CAMuHMdVe_kb4jBBXNpNUFk8ey4zo_w4y2NQ0xKeH4NXkUDN+UA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1500229392-30817-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1500229392-30817-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>

On Sun, Jul 16, 2017 at 8:23 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.13-rc1[1] compared to v4.12[2].
>
> Summarized:
>   - build errors: +2/-

> [1] http://kisskb.ellerman.id.au/kisskb/head/5771a8c08880cdca3bfb4a3fc6d309d6bba20877/ (all 267 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c/ (all 267 configs)

> 2 error regressions:
>   + /home/kisskb/slave/src/arch/sh/mm/cache-sh4.c: error: 'cached_to_uncached' undeclared (first use in this function):  => 99:17
>   + /home/kisskb/slave/src/arch/sh/mm/cache-sh4.c: error: implicit declaration of function 'cpu_context' [-Werror=implicit-function-declaration]:  => 192:2

sh4-randconfig, nothing new, pops up once in a while.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
