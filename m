From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jul 2015 10:22:42 +0000
Subject: Re: [PATCH 0/4 v2][RFC] arm64: Renesas Gen3 initial patch
Message-Id: <CAMuHMdWxUiLdQe+9KrMj1fPF13wjtsaoPB00E2yH+4GphOn+aQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878uazm9gu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878uazm9gu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Mon, Jul 13, 2015 at 7:26 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> No objection about these Gen3 prototype patches ?
> If so, I will post these in SH-ML and ARM-ML as formal (= non RFC) patch set
>
>> Gaku Inami (3):
>>       clk: shmobile: add Renesas R-Car Gen3 CPG support
>>       arm64: Add new Renesas R-Car Gen3 SoC Kconfig
>>       arm64: renesas: Add initial r8a7795 SoC support
>>
>> Kuninori Morimoto (1):
>>       arm64: defconfig: Enable Renesas R-Car Gen3 SoC in defconfig
>>
>>  Documentation/devicetree/bindings/arm/shmobile.txt                       |   2 +
>>  Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt |  31 ++++++++++++
>>  drivers/clk/shmobile/clk-rcar-gen3.c                                     | 232 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/dt-bindings/clock/r8a7795-clock.h                                |  31 ++++++++++++
>>  10 files changed, 409 insertions(+)

If possible, I would like to have support for the "CPG/MSTP Clock Domain"
from the beginning, to avoid having to break DTS compatibility.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
