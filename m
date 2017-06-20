From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Jun 2017 07:42:04 +0000
Subject: Re: Build regressions/improvements in v4.12-rc6
Message-Id: <CAMuHMdVR_Xysupx3u0PXgiRJJP1DLfw+1rXGZzpi8DF4KJGFzw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1497944373-26837-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1497944373-26837-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>

On Tue, Jun 20, 2017 at 9:39 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.12-rc6[1] to v4.12-rc5[3], the summaries are:
>   - build errors: +4/-

  + /home/kisskb/slave/src/arch/sh/boards/mach-sh03/setup.c: error:
implicit declaration of function 'ioremap_prot'
[-Werror=implicit-function-declaration]:  => 85:2

sh-randconfig

  + error: "__udivdi3" [fs/ufs/ufs.ko] undefined!:  => N/A

Lots of 32-bit platforms

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
