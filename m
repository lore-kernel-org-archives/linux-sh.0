From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Dec 2019 07:49:58 +0000
Subject: Re: [PATCH] sh: add missing DECLARE_EXPORT() for __ashiftrt_r4_2x
Message-Id: <CAMuHMdU2LTuOeNAm4bHbei6LOcvEWbwS=WzVSGkZE0kw8RA0kA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87v9qmcloc.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87v9qmcloc.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Morimoto-san,

On Thu, Dec 12, 2019 at 3:39 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> __ashiftrt_r4_2x is used from kernel module.
> We need DECLARE_EXPORT(), otherwise we will get compile error.
>
> ERROR: "__ashiftrt_r4_25" [drivers/iio/pressure/bmp280.ko] undefined!
> ERROR: "__ashiftrt_r4_26" [drivers/iio/dac/ad5764.ko] undefined!
> ERROR: "__ashiftrt_r4_26" [drivers/iio/accel/mma7660.ko] undefined!
> ERROR: "__ashiftrt_r4_25" [drivers/iio/accel/dmard06.ko] undefined!
> ERROR: "__ashiftrt_r4_26" [drivers/iio/accel/bma220_spi.ko] undefined!
> ERROR: "__ashiftrt_r4_25" [drivers/crypto/hisilicon/sec/hisi_sec.ko] undefined!
> ERROR: "__ashiftrt_r4_26" [drivers/rtc/rtc-x1205.ko] undefined!
> ERROR: "__ashiftrt_r4_25" [drivers/rtc/rtc-pcf85063.ko] undefined!
> ERROR: "__ashiftrt_r4_25" [drivers/rtc/rtc-pcf2123.ko] undefined!
> ERROR: "__ashiftrt_r4_25" [drivers/input/tablet/gtco.ko] undefined!
> ERROR: "__ashiftrt_r4_26" [drivers/input/mouse/psmouse.ko] undefined!
> ERROR: "__ashiftrt_r4_28" [drivers/input/mouse/psmouse.ko] undefined!
> ERROR: "__ashiftrt_r4_28" [drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.ko] undefined!
> ERROR: "__ashiftrt_r4_28" [fs/udf/udf.ko] undefined!
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/sh/kernel/sh_ksyms_32.c
> +++ b/arch/sh/kernel/sh_ksyms_32.c
> @@ -53,8 +53,14 @@ DECLARE_EXPORT(__ashiftrt_r4_21);
>  DECLARE_EXPORT(__ashiftrt_r4_22);
>  DECLARE_EXPORT(__ashiftrt_r4_23);
>  DECLARE_EXPORT(__ashiftrt_r4_24);
> +DECLARE_EXPORT(__ashiftrt_r4_25);
> +DECLARE_EXPORT(__ashiftrt_r4_26);
>  DECLARE_EXPORT(__ashiftrt_r4_27);
> +DECLARE_EXPORT(__ashiftrt_r4_28);
> +DECLARE_EXPORT(__ashiftrt_r4_29);
>  DECLARE_EXPORT(__ashiftrt_r4_30);
> +DECLARE_EXPORT(__ashiftrt_r4_31);
> +DECLARE_EXPORT(__ashiftrt_r4_32);
>  DECLARE_EXPORT(__movstr);
>  DECLARE_EXPORT(__movstrSI8);
>  DECLARE_EXPORT(__movstrSI12);

Wouldn't it make sense to just add all of them (__ashiftrt_r4_[0-32])?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
