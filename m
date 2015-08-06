From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 06 Aug 2015 10:08:02 +0000
Subject: Re: [PATCH 06/13 v4][RFC] arm64: renesas: enable SCIF on defconfig
Message-Id: <CAMuHMdWBK1Y=bu92J+h0bAMPOD4M_=8Vrb4jZ=uqMxYt3_Ej4A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87oaikyhba.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oaikyhba.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -106,6 +106,9 @@ CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_8250_MT6577=y
>  CONFIG_SERIAL_AMBA_PL011=y
>  CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
> +CONFIG_SERIAL_SH_SCI=y
> +CONFIG_SERIAL_SH_SCI_NR_UARTS=6

11?

6 x SCIF + 5 x HSCIF

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
