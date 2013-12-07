From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 07 Dec 2013 16:14:45 +0000
Subject: Re: Build regressions/improvements in v3.13-rc3
Message-Id: <CAMuHMdW_sS2+8yrXRPyiToiWhRWn4PjLMNQid63So3ikwogJvg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386432168-26334-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1386432168-26334-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>

On Sat, Dec 7, 2013 at 5:02 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.13-rc3[1]  to v3.13-rc2[3], the summaries are:
>   - build errors: +3/-4

  + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error:
'cached_to_uncached' undeclared (first use in this function):  =>
99:17
  + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error: implicit
declaration of function 'cpu_context'
[-Werror=implicit-function-declaration]:  => 192:2

sh-randconfig

  + error: No rule to make target drivers/scsi/aic7xxx/aicasm/*.[chyl]:  => N/A

x86_64-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/6964/ (119 out of 120 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6939/ (119 out of 120 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
