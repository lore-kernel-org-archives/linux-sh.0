From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Aug 2015 07:30:09 +0000
Subject: Re: [PATCH v2 01/07] devicetree: bindings: Renesas APMU and SMP Enable method
Message-Id: <CAMuHMdWDEYJjRUKo=YdCbPB1UAd_hLEJaXFBFarpDNQ7ObPciQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150823072427.14156.1960.sendpatchset@little-apple>
	<20150823072439.14156.96621.sendpatchset@little-apple>
In-Reply-To: <20150823072439.14156.96621.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, =?UTF-8?B?5bCP5p6X5pWs5aSq?= <keita.kobayashi.ym@renesas.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Magnus,

On Sun, Aug 23, 2015 at 9:24 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Add DT binding documentation for the APMU hardware and add "renesas,apmu"
> to the list of enable methods for the ARM cpus.

Thanks!

> --- /dev/null
> +++ work/Documentation/devicetree/bindings/power/renesas,apmu.txt       2015-05-20 22:39:34.872366518 +0900
> @@ -0,0 +1,31 @@

> +- cpus: This node contains a list of CPU cores, which should match the order
> +  of CPU cores used by the WUPCR and PSTR registers in the Advanced Power
> +  Management Until section of the device's datasheet.

s/Until/Unit/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
