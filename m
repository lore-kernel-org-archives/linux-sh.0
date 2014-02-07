From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 07 Feb 2014 12:45:07 +0000
Subject: Re: [PATCH] sh: sh7757: switch RSPI clock to dev ID match
Message-Id: <CAMuHMdUYc8Ceid2z3c2Bm1ZDteu2iV-O4cPX4LdxiTnzhsh_Rw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389522649-1753-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1389522649-1753-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-sh list <linux-sh@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

On Sun, Jan 12, 2014 at 11:30 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>
> Switch the RSPI MSTP clock on SH7757 from a con ID match to a dev ID
> match, so we can start looking it up using clk_get() with a NULL ID.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> ---
> Untested, as I don't have the hardware, but this is a prerequisite for
> "spi: rspi: Use NULL as the clock ID".

Is there anyone who can test this?

"spi: rspi: Use NULL as the clock ID" is queued for v3.15:
https://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/commit/drivers/spi/spi-rspi.c?h=for-next&id)f397b739ceef90c8b848f6579cbacd088e896e
and this patch should go in first.

Thanks!

>  arch/sh/kernel/cpu/sh4a/clock-sh7757.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
> index e84a43229b9c..5c0e3c335161 100644
> --- a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
> +++ b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
> @@ -132,7 +132,7 @@ static struct clk_lookup lookups[] = {
>         CLKDEV_CON_ID("usb_fck", &mstp_clks[MSTP103]),
>         CLKDEV_DEV_ID("renesas_usbhs.0", &mstp_clks[MSTP102]),
>         CLKDEV_CON_ID("mmc0", &mstp_clks[MSTP220]),
> -       CLKDEV_CON_ID("rspi2", &mstp_clks[MSTP127]),
> +       CLKDEV_DEV_ID("rspi.2", &mstp_clks[MSTP127]),
>  };
>
>  int __init arch_clk_init(void)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
