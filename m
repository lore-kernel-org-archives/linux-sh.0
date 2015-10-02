From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 02 Oct 2015 07:11:50 +0000
Subject: Re: [PATCH v10 04/07] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
Message-Id: <CAMuHMdWiJy5g8_zFP=+obuLJRvv4XrgMre_0pnG2Nyhc9QRDdQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20151002025551.28158.20307.sendpatchset@little-apple>
In-Reply-To: <20151002025551.28158.20307.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 2, 2015 at 4:55 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> --- 0012/include/dt-bindings/clock/r8a7795-clock.h
> +++ work/include/dt-bindings/clock/r8a7795-clock.h      2015-10-01 19:24:51.200513000 +0900
> @@ -22,8 +22,14 @@
>  /* MSTP1 */
>
>  /* MSTP2 */
> +#define R8A7795_CLK_SCIF5              202
> +#define R8A7795_CLK_SCIF4              203
> +#define R8A7795_CLK_SCIF3              204
> +#define R8A7795_CLK_SCIF1              206
> +#define R8A7795_CLK_SCIF0              207
>
>  /* MSTP3 */
> +#define R8A7795_CLK_SCIF2              210

310

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
