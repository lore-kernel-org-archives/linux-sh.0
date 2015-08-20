From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Aug 2015 09:55:52 +0000
Subject: Re: [PATCH 10/17 v6][RFC] arm64: renesas: add SalvatorX board support on DTS
Message-Id: <CAMuHMdXqQFZ7gVqpArce3fkZZvi0FROg+Uj+xCv0OtVSTx3YSw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878u96b9ei.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878u96b9ei.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 20, 2015 at 11:27 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> @@ -0,0 +1,46 @@
> +/*
> + * Device Tree Source for the SalvatorX board

Salvator-X

> + *
> + * Copyright (C) 2015 Renesas Electronics Corp.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +#include "r8a7795.dtsi"
> +
> +/ {
> +       model = "Renesas SalvatorX board based on r8a7795";

Salvator-X

+ the subject of the patch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
