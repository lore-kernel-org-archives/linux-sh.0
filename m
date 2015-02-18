From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Feb 2015 09:07:57 +0000
Subject: Re: [PATCH 01/05] ARM: shmobile: r8a7779: Configure IRLM mode via DT
Message-Id: <CAMuHMdX6U-bumrq7w9FjMFvV6K9NBM_z-1cf-NzqaLBsVY_POQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150218023822.12588.71014.sendpatchset@little-apple>
In-Reply-To: <20150218023822.12588.71014.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 18, 2015 at 3:38 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Adjust the r8a7779 SoC DTS and the Marzen Reference
> C board code to use DTS only for INTC-IRQPIN IRLM setup.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

with one minor nit:

> --- 0002/arch/arm/boot/dts/r8a7779.dtsi
> +++ work/arch/arm/boot/dts/r8a7779.dtsi 2014-12-03 20:27:49.000000000 +0900
> @@ -139,7 +139,7 @@
>                 interrupt-controller;
>         };
>
> -       irqpin0: irqpin@fe780010 {
> +       irqpin0: irqpin@fe780000 {

ePAPR says: "The unit-address must match the first address specified in the
reg property of the node."

Hence it should be "irqpin0: irqpin@fe78001c {".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
