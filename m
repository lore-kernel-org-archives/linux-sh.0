From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 Jan 2016 08:24:06 +0000
Subject: Re: Build regressions/improvements in v4.5-rc1
Message-Id: <CAMuHMdXPFRRJvw4wC8kHvSo7zbcv9159EeRjzh2xiQ_+8zxb6w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1453709909-15240-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1453709909-15240-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>

On Mon, Jan 25, 2016 at 9:18 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.5-rc1[1] compared to v4.4[2].
>
> Summarized:
>   - build errors: +15/-23

> [1] http://kisskb.ellerman.id.au/kisskb/head/9841/ (all 261 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/9774/ (259 out of 261 configs)
>
>
> *** ERRORS ***
>
> 15 error regressions:
>   + /home/kisskb/slave/src/arch/sh/drivers/dma/dma-sh.c: error: 'DMTE6_IRQ' undeclared (first use in this function):  => 58:21

sh-randconfig

>   + /home/kisskb/slave/src/drivers/gpu/drm/vc4/vc4_v3d.c: error: called object '0u' is not a function:  => 157:29, 159:27

cris-allmodconfig
cris-allyesconfig
m32r/m32700ut.smp_defconfig
m68k-allmodconfig
parisc-allmodconfig
sh-randconfig
xtensa-allmodconfig

>   + /home/kisskb/slave/src/sound/core/compress_offload.c: error: case label does not reduce to an integer constant:  => 804:2

ppc64le/allmodconfig+ppc64le

>   + /tmp/ccDC0dZh.s: Error: can't resolve `_start' {*UND* section} - `L0 ' {.text section}:  => 378, 49
>   + /tmp/ccGniXga.s: Error: can't resolve `_start' {*UND* section} - `L0 ' {.text section}:  => 43
>   + /tmp/ccci5ABy.s: Error: can't resolve `_start' {*UND* section} - `L0 ' {.text section}:  => 366, 49
>   + /tmp/cccq2wZf.s: Error: can't resolve `_start' {*UND* section} - `L0 ' {.text section}:  => 43
>   + /tmp/cchnfEGb.s: Error: can't resolve `_start' {*UND* section} - `L0 ' {.text section}:  => 43

(reported before)

mips-allnoconfig
mips-defconfig
ip27_defconfig

>   + error: No rule to make target include/config/auto.conf:  => N/A

arm-randconfig (reported before)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
