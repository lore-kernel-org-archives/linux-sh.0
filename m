From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jun 2015 08:11:12 +0000
Subject: Re: [PATCH 5/6][RFC] arm64: renesas: Add r8a7795 SoC support
Message-Id: <CAMuHMdUHGD1LjVPO=cwjuj38LtZm50OjEooj4mH6AiM_i0YFBg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87y4jlvait.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y4jlvait.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san, Inami-san,

On Mon, Jun 15, 2015 at 6:54 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -0,0 +1,90 @@
> +/*
> + * Device Tree Source for the r8a7795 SoC
> + *
> + * Copyright (C) 2015 Renesas Electronics Corp.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +/dts-v1/;
> +
> +#include <dt-bindings/clock/r8a7795-clock.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +       compatible = "renesas,r8a7795";

ideally, this compatible value should be documented before it's being used.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
