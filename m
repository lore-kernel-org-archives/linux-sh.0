From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Aug 2015 11:01:50 +0000
Subject: Re: [PATCH/RFC 04/10] ravb: Add support for r8a7795 SoC
Message-Id: <CAMuHMdWJ3osW7GLwZuOJTif34HMBuYd8YyarzMaADVz3a5iV5Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 27, 2015 at 11:24 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
> +++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
> @@ -6,8 +6,12 @@ interface contains.
>  Required properties:
>  - compatible: "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
>               "renesas,etheravb-r8a7794" if the device is a part of R8A7794 SoC.
> +             "renesas,etheravb-r8a7795" if the device is a part of R8A7795 SoC.
>  - reg: offset and length of (1) the register block and (2) the stream buffer.
> -- interrupts: interrupt specifier for the sole interrupt.
> +- interrupts: if the device is a part of R8A7790/R8A7794 SoC
> +              interrupt specifier for the sole interrupt.
> +              if the device is a part of R8A7795 SoC
> +              interrupt specifier for the two interrupts.

If there are multiple interrupts, you best make them named interrupts,
i.e. requiring "interrupt-names", too.

Why are there only 2 interrupts? The datasheet mentions 25, for ch0-ch24.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
