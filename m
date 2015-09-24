From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 24 Sep 2015 07:04:20 +0000
Subject: Re: [PATCH] tmio_mmc_pio: test TMIO_MMC_WRPROTECT_DISABLE earlier
Message-Id: <CAMuHMdUicoDv-MROEVGqsM-o7hiCqBdkjK3Tn45zE0r5Z1hofQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1513691.2yatcrs42i@wasted.cogentembedded.com>
In-Reply-To: <1513691.2yatcrs42i@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Ian Molton <ian@mnementh.co.uk>, Linux-sh list <linux-sh@vger.kernel.org>

On Thu, Sep 24, 2015 at 1:58 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> There seems  to be no sense in the runtime PM calls when the actual register
> read is suppressed by the TMIO_MMC_WRPROTECT_DISABLE flag.  Check that flag
> before trying to read the register and  thus doing the runtime PM dance...
>
> While at it, kill useless local variable and add empty line after declarations.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
