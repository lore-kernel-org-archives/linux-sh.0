From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Feb 2014 09:54:17 +0000
Subject: Re: Build regressions/improvements in v3.14-rc4
Message-Id: <CAMuHMdVXF2LgyCnf8eGoVQ5LpWe4r06tA+fvjmakvrBqX9hzwg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1393408336-1367-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1393408336-1367-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Wed, Feb 26, 2014 at 10:52 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.14-rc4[1]  to v3.14-rc3[3], the summaries are:
>   - build errors: +3/-15

  + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error:
'cached_to_uncached' undeclared (first use in this function):  =>
99:17
  + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error: implicit
declaration of function 'cpu_context'
[-Werror=implicit-function-declaration]:  => 192:2

sh-randconfig

  + error: No rule to make target include/config/auto.conf:  => N/A

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7212/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7190/ (all 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
