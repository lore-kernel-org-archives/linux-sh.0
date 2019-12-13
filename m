From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 13 Dec 2019 00:02:43 +0000
Subject: Re: [PATCH] sh: add missing DECLARE_EXPORT() for __ashiftrt_r4_2x
Message-Id: <87o8wd5bz1.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87v9qmcloc.wl-kuninori.morimoto.gx@renesas.com>
        <CAMuHMdU2LTuOeNAm4bHbei6LOcvEWbwS=WzVSGkZE0kw8RA0kA@mail.gmail.com>
In-Reply-To: <CAMuHMdU2LTuOeNAm4bHbei6LOcvEWbwS=WzVSGkZE0kw8RA0kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Hi Geert

Thank you for your review

> > __ashiftrt_r4_2x is used from kernel module.
> > We need DECLARE_EXPORT(), otherwise we will get compile error.
> >
> > ERROR: "__ashiftrt_r4_25" [drivers/iio/pressure/bmp280.ko] undefined!
> > ERROR: "__ashiftrt_r4_26" [drivers/iio/dac/ad5764.ko] undefined!
> > ERROR: "__ashiftrt_r4_26" [drivers/iio/accel/mma7660.ko] undefined!
> > ERROR: "__ashiftrt_r4_25" [drivers/iio/accel/dmard06.ko] undefined!
> > ERROR: "__ashiftrt_r4_26" [drivers/iio/accel/bma220_spi.ko] undefined!
> > ERROR: "__ashiftrt_r4_25" [drivers/crypto/hisilicon/sec/hisi_sec.ko] undefined!
> > ERROR: "__ashiftrt_r4_26" [drivers/rtc/rtc-x1205.ko] undefined!
> > ERROR: "__ashiftrt_r4_25" [drivers/rtc/rtc-pcf85063.ko] undefined!
> > ERROR: "__ashiftrt_r4_25" [drivers/rtc/rtc-pcf2123.ko] undefined!
> > ERROR: "__ashiftrt_r4_25" [drivers/input/tablet/gtco.ko] undefined!
> > ERROR: "__ashiftrt_r4_26" [drivers/input/mouse/psmouse.ko] undefined!
> > ERROR: "__ashiftrt_r4_28" [drivers/input/mouse/psmouse.ko] undefined!
> > ERROR: "__ashiftrt_r4_28" [drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.ko] undefined!
> > ERROR: "__ashiftrt_r4_28" [fs/udf/udf.ko] undefined!
(snip)
> Wouldn't it make sense to just add all of them (__ashiftrt_r4_[0-32])?

Oops, there are more missing __ashiftrt_r4_xx
Thank you for pointing it.
will post v2

Thank you for your help !!
Best regards
---
Kuninori Morimoto
