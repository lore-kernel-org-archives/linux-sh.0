From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Feb 2014 08:19:02 +0000
Subject: Re: [PATCH v2 01/02] ARM: shmobile: Add SDHI devices to r8a7791 DTSI
Message-Id: <CAMuHMdVsh4hG0VruqJBatkGCvhtgUYXAYxR930UZS-QAdoN8gw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140212074119.23493.28243.sendpatchset@w520>
In-Reply-To: <20140212074119.23493.28243.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Wed, Feb 12, 2014 at 8:41 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Changes since V1:
>  - add r8a7790 suffix as fall back in case r8a7791 is missing from the driver

I'm afraid that's not such a good idea: what if r8a7791 SDHI turns out to have a
slight incompatibility with r8a7790 SDHI later?

What about adding "renesas,sdhi-rcar-gen2" as a fallback instead, for
both r8a7790
and r8a7791?
This would reduce the size of the sh_mobile_sdhi_of_match[] table in
drivers/mmc/host/sh_mobile_sdhi.c, as no SoC-specific entries are needed at
the moment.

A similar thing can be done for "renesas,sdhi-rcar-gen1" (as long as those DTSes
are not in mainline).

>  arch/arm/boot/dts/r8a7791.dtsi |   27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> --- 0001/arch/arm/boot/dts/r8a7791.dtsi
> +++ work/arch/arm/boot/dts/r8a7791.dtsi 2014-02-12 16:29:40.000000000 +0900
> @@ -186,6 +186,33 @@
>                 #gpio-range-cells = <3>;
>         };
>
> +       sdhi0: sd@ee100000 {
> +               compatible = "renesas,sdhi-r8a7791", "renesas,sdhi-r8a7790";

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
