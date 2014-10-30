From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Oct 2014 09:35:09 +0000
Subject: Re: [PATCH 02/11] ARM: shmobile: r8a7790: Add Audio DMAC peri peri devices to DT
Message-Id: <CAMuHMdVoGhD=irErv=x1dbQTU4B0bxP9Vu5N5PV97=7JzKns2Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392907779-22053-3-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1392907779-22053-3-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 30, 2014 at 9:26 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -369,6 +369,13 @@
>                 dma-channels = <13>;
>         };
>
> +       audmapp: audio-dma-pp@0xec740000 {

Please remove the "0x" prefix from the unit-address.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
