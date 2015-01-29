From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 29 Jan 2015 09:45:33 +0000
Subject: Re: [PATCH 1/2][RFC] dmaengine: rcar-audmapp: calculate chcr via src/dst addr
Message-Id: <87vbjpsyvb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761ekokpf.wl%kuninori.morimoto.gx@renesas.com>
	<877fw6tm4v.wl%kuninori.morimoto.gx@renesas.com>
	<8761bqtm34.wl%kuninori.morimoto.gx@renesas.com>
	<16757441.qC3ryuq0R5@wuerfel>
	<CAMuHMdX5SEwEARo7dFTZrtuDXbrv2MeZrOZFWsahNhccWPNn_A@mail.gmail.com>
In-Reply-To: <CAMuHMdX5SEwEARo7dFTZrtuDXbrv2MeZrOZFWsahNhccWPNn_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@linaro.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, dmaengine@vger.kernel.org


Hi Geert

> >> +static u32 audmapp_addr_to_id(struct device *dev, u32 addr)
> >> +{
> >> +     struct id_addr_table ssi_id_table[] = {
> 
> static const, so they don't get copied to the stack on every invocation.

Indeed, thanks

> >> +             {0x00, 0x0000}, /* SSI00 */
> >> +             {0x01, 0x0400}, /* SSI01 */
> >> +             {0x02, 0x0800}, /* SSI02 */
> >> +             {0x03, 0x0C00}, /* SSI03 */
> >> +             {0x04, 0x1000}, /* SSI10 */
> >> +             {0x05, 0x1400}, /* SSI11 */
> >> +             {0x06, 0x1800}, /* SSI12 */
> >> +             {0x07, 0x1C00}, /* SSI13 */
> >> +             {0x08, 0x2000}, /* SSI20 */
> >
> > Isn't the address part here the physical address of the FIFO,
> 
> Yes they are.
> 
> > which can be different for each implementation that contains
> > an audmapp device?
> 
> Fortunately they're identical for all (current) members of the R-Car Gen2
> family.
> 
> Morimoto-san: Are the base addresses configured in DT?
> I did a quick search for 0xec300000, 0xec320000, 0xec40000,
> 0xec420000, and 0xec000000,  and couldn't find them in DT, only in
> source code (comments). They must come from somewhere?
> Note that I didn't follow the sound binding discussions that closely.

This base addresses are specified from sound driver.
 - sound driver specifies src/dst address by DMAEngine API
 - audmapp find necessary ID from src/dst address

Best regards
---
Kuninori Morimoto
