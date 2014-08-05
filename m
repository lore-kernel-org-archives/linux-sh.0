From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 05 Aug 2014 23:45:06 +0000
Subject: Re: [PATCH 1/5] mmc: shmobile: add renesas,sdhi-rcar-gen1/gen2 in DT compatible
Message-Id: <87a97ilcw3.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mwbso8sp.wl%kuninori.morimoto.gx@gmail.com>
	<87vbq7ocbi.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdWrbT2vvn+H=R1QhoUNzyPDUFoYMsPjtFW2sPOkVyCScw@mail.gmail.com>
In-Reply-To: <CAMuHMdWrbT2vvn+H=R1QhoUNzyPDUFoYMsPjtFW2sPOkVyCScw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, goda <yusuke.goda.sx@renesas.com>, Linux MMC List <linux-mmc@vger.kernel.org>


Hi Geert

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > This patch adds DT compatible for Renesas R-Car Gen1/Gen2.
> > Current driver has SoC level .compatible
> > (r8a7778/r8a7779/r8a7790/r8a7791),
> > but these can be match as generation level.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  drivers/mmc/host/sh_mobile_sdhi.c |    2 ++
> >  1 file changed, 2 insertions(+)
> 
> I think you should also update
> Documentation/devicetree/bindings/mmc/tmio_mmc.txt

Indeed, thanks
Will do in v2

Best regards
---
Kuninori Morimoto
