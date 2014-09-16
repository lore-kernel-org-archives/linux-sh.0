From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Sep 2014 08:34:34 +0000
Subject: Re: [PATCH v2] of: Add vendor prefix for Sitronix
Message-Id: <CAMuHMdXWpRyj7ke-RV0t0G4CzS1_5bCOpCYuOA1TiLZxTPYNUA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409212074-2966-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1409212074-2966-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

ping?

On Thu, Aug 28, 2014 at 9:47 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The stock ticker for Sitronix is just a number.
> "sitronix,st1232" is already in use for the Sitronix st1232 touchscreen
> controller on Atmark Techno Armadillo 800 EVA.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2: Mention armadillo
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 34cc1bfcebfd..41799a69964b 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -126,6 +126,7 @@ silabs      Silicon Laboratories
>  simtek
>  sii    Seiko Instruments, Inc.
>  sirf   SiRF Technology, Inc.
> +sitronix       Sitronix Technology Corporation
>  smsc   Standard Microsystems Corporation
>  snps   Synopsys, Inc.
>  solidrun       SolidRun
> --
> 1.9.1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
