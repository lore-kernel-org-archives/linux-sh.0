From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Nov 2012 20:56:06 +0000
Subject: Re: Build regressions/improvements in v3.7-rc7
Message-Id: <CAMuHMdWjpQ1+=MoxUCLvv4dMkjVV3Y2XoiwFWbHMTkZeeOQheQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1353963243-21887-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1353963243-21887-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Linux-sh list <linux-sh@vger.kernel.org>

On Mon, Nov 26, 2012 at 9:54 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.7-rc7 to v3.7-rc6[3], the summaries are:
>   - build errors: +4/-8

  + error: "__sync_fetch_and_and_4"
[drivers/staging/line6/line6usb.ko] undefined!:  => N/A
  + error: "__sync_fetch_and_or_4" [drivers/staging/line6/line6usb.ko]
undefined!:  => N/A

sh4/sh-randconfig

  + error: "smp_send_reschedule" [arch/powerpc/kvm/kvm.ko] undefined!:  => N/A

powerpc/powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/5646/ (all 117 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/5628/ (all 117 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
