From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Jan 2015 09:50:28 +0000
Subject: Re: [PATCH 1/2][RFC] dmaengine: rcar-audmapp: calculate chcr via src/dst addr
Message-Id: <CAMuHMdXHOYfuA0kV31ExirgvLtL6BqWMKHbPbxTzVNp25HzHDw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761ekokpf.wl%kuninori.morimoto.gx@renesas.com>
	<877fw6tm4v.wl%kuninori.morimoto.gx@renesas.com>
	<8761bqtm34.wl%kuninori.morimoto.gx@renesas.com>
	<16757441.qC3ryuq0R5@wuerfel>
	<CAMuHMdX5SEwEARo7dFTZrtuDXbrv2MeZrOZFWsahNhccWPNn_A@mail.gmail.com>
	<87vbjpsyvb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbjpsyvb.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@linaro.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, dmaengine@vger.kernel.org

Hi Morimoto-san,

On Thu, Jan 29, 2015 at 10:45 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> Morimoto-san: Are the base addresses configured in DT?
>> I did a quick search for 0xec300000, 0xec320000, 0xec40000,
>> 0xec420000, and 0xec000000,  and couldn't find them in DT, only in
>> source code (comments). They must come from somewhere?
>> Note that I didn't follow the sound binding discussions that closely.
>
> This base addresses are specified from sound driver.
>  - sound driver specifies src/dst address by DMAEngine API

From the rcar_sound node? That one has 0xec500000 as the base address.

>  - audmapp find necessary ID from src/dst address

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
