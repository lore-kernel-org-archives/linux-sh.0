From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2015 07:11:03 +0000
Subject: Re: [PATCH 06/25 v7][RFC] arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
Message-Id: <CAMuHMdVz=o4V=+9xq2ZP2eGwycRToAomhUh_j_LgfupVo9uhdA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87k2sl77bs.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k2sl77bs.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tue, Aug 25, 2015 at 1:46 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> > From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>> >
>> > Initial version of device tree for Renesas R-Car Gen3 SoC Kconfig
>>
>> Device tree?
>
> This line was copied from
>
> -----------------------------------
> commit 5d1b79d2b2639bb71238e76d73431fada9e38553
> Author: Michal Simek <michal.simek@xilinx.com>
> Date:   Mon Mar 9 09:41:04 2015 +0100
>
>     ARM64: Add new Xilinx ZynqMP SoC
>
>     Initial version of device tree for Xilinx ZynqMP SoC.
>
>     Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>     Acked-by: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> -----------------------------------
> commit 419043609689d0aba9f727a6faf1ff406e269ecf
> Author: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Date:   Wed Nov 26 11:51:09 2014 +0700
>
>     arm64: amd-seattle: Adding device tree for AMD Seattle platform
>
>     Initial revision of device tree for AMD Seattle Development platform.

These two commits did add *.dtsi files, while Inami-san's patch only added
the Kconfig bits.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
