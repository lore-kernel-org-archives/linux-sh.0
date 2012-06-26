From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 Jun 2012 20:06:27 +0000
Subject: Re: Build regressions/improvements in v3.5-rc4
Message-Id: <CAMuHMdXY1DFNV+jTiJkT99TbX7ZL5eEiKcG0iqZkUa8T7YZG4g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1340740795-19603-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1340740795-19603-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: the arch/x86 maintainers <x86@kernel.org>, linuxppc-dev@lists.ozlabs.org, Linux-sh list <linux-sh@vger.kernel.org>

On Tue, Jun 26, 2012 at 9:59 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.5-rc4 to v3.5-rc3[3], the summaries are:
>  - build errors: +11/-219

11 regressions:
  + arch/sh/include/asm/fixmap.h: error: implicit declaration of
function 'BUG_ON' [-Werror=implicit-function-declaration]:  => 133:2
  + arch/sh/include/asm/thread_info.h: error: implicit declaration of
function 'WARN_ON' [-Werror=implicit-function-declaration]:  => 172:2
  + include/linux/huge_mm.h: error: implicit declaration of function
'BUG' [-Werror=implicit-function-declaration]:  => 185:2

shmin_defconfig, se7712_defconfig, se7721_defconfig, sh-allnoconfig

  + arch/x86/include/asm/paravirt.h: error: implicit declaration of
function 'BUG_ON' [-Werror=implicit-function-declaration]:  => 25:2
  + arch/x86/include/asm/processor.h: error: implicit declaration of
function 'WARN_ON_ONCE' [-Werror=implicit-function-declaration]:  =>
936:2
  + arch/x86/include/asm/thread_info.h: error: implicit declaration of
function 'WARN_ON' [-Werror=implicit-function-declaration]:  => 251:2
  + include/linux/slub_def.h: error: implicit declaration of function
'BUG' [-Werror=implicit-function-declaration]:  => 192:2

i386-randconfig

  + error: of_platform.c: undefined reference to
`.pcibios_claim_one_bus':  => .devinit.text+0x160)

powerpc-randconfig

  + include/asm-generic/pgtable.h: error: implicit declaration of
function 'BUG' [-Werror=implicit-function-declaration]:  => 56:2
  + include/asm-generic/pgtable.h: error: implicit declaration of
function 'BUG':  => 56
  + include/linux/thread_info.h: error: implicit declaration of
function 'WARN_ON':  => 129

avr32-allnoconfig

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
