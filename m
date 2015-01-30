From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Jan 2015 01:17:46 +0000
Subject: Re: [alsa-devel] [PATCH 1/2][RFC] dmaengine: rcar-audmapp:	calculate chcr via src/dst addr
Message-Id: <87lhklf4ll.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761ekokpf.wl%kuninori.morimoto.gx@renesas.com>
	<877fw6tm4v.wl%kuninori.morimoto.gx@renesas.com>
	<8761bqtm34.wl%kuninori.morimoto.gx@renesas.com>
	<16757441.qC3ryuq0R5@wuerfel>
	<CAMuHMdX5SEwEARo7dFTZrtuDXbrv2MeZrOZFWsahNhccWPNn_A@mail.gmail.com>
	<87vbjpsyvb.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdXHOYfuA0kV31ExirgvLtL6BqWMKHbPbxTzVNp25HzHDw@mail.gmail.com>
	<87oaphf6xz.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oaphf6xz.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Simon <horms@verge.net.au>, Linux-ALSA <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@linaro.org>, Vinod Koul <vinod.koul@intel.com>, Linux-SH <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dmaengine@vger.kernel.org


Hi Geert, again

> > >> Morimoto-san: Are the base addresses configured in DT?
> > >> I did a quick search for 0xec300000, 0xec320000, 0xec40000,
> > >> 0xec420000, and 0xec000000,  and couldn't find them in DT, only in
> > >> source code (comments). They must come from somewhere?
> > >> Note that I didn't follow the sound binding discussions that closely.
> > >
> > > This base addresses are specified from sound driver.
> > >  - sound driver specifies src/dst address by DMAEngine API
> > 
> > From the rcar_sound node? That one has 0xec500000 as the base address.
> 
> Thank you. I double checked, and remembered.
> This is a littile bit confusable.
> 
> FIFO address 1) for CPU 2) for Audio DMAC 3) for Audio DMAC peri peri are different
> Sound driver is understanding all addresses.
> But, hmm..  no one call request_region() for these, is this your concern ?

Sorry for my confusable mail.
Yes, I need to add these address from DT. I fixup it in v2

0xec420000, 0xec320000 are listed on this patch, but these are not supported yet.
