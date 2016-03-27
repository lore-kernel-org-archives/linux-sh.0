From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 27 Mar 2016 12:43:24 +0000
Subject: Re: Build regressions/improvements in v4.6-rc1
Message-Id: <CAMuHMdW3dfhZVT0e4tiqsbEPjYYA_hGUXQer1bQDeF2Gbs4WJg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdXx80zs5VoA_aYc_wMn37O=fa6oXk-ovteHq0hGQYUUzg@mail.gmail.com>
In-Reply-To: <CAMuHMdXx80zs5VoA_aYc_wMn37O=fa6oXk-ovteHq0hGQYUUzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Rich Felker <dalias@libc.org>, Cris <linux-cris-kernel@axis.com>, xfs@oss.sgi.com

On Sun, Mar 27, 2016 at 2:39 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.6-rc1[1] compared to v4.5[2].
>
> Summarized:
>   - build errors: +9/-6

> [1] http://kisskb.ellerman.id.au/kisskb/head/10114/ (all 262 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/10047/ (all 262 configs)

> 9 error regressions:
>   + /home/kisskb/slave/src/fs/xfs/xfs_ondisk.h: error: call to
> '__compiletime_assert_79' declared with attribute error: XFS:
> sizeof(xfs_attr_shortform_t) is wrong, expected 8:  => 79:2

cris-allyesconfig, cris-allmodconfig

>   + error: smp-shx3.c: undefined reference to `local_timer_setup':  =>
> .text+0xadec)

shx3_defconfig

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
