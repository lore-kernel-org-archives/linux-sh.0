From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 04 Aug 2014 09:44:43 +0000
Subject: Re: [PATCH 3/3] dma: rcar-audmapp: add DT support
Message-Id: <87silcwpv9.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ppi6y4n2.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ppi6y4n2.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> > +Required properties:
> > +- dmas:                a list of <[DMA multiplexer phandle] [SRS/DRS value]> pairs,
> > +               where SRS/DRS values are fixed handles, specified in the SoC
> > +               manual as the value that would be written into the PDMACHCR.
> 
> I think this wording is a little bit confusing.
> It's not the "value that would be written into the PDMACHCR", but the
> high 16-bit
> part of that value, cfr. the example and the actual code below.
> 
> An alternative way of saying this could be "SRS << 8 | DRS", which clearly
> shows how to combine SRS and DRS.
> Unlike the docs for SYS-DMAC, which contains a table of combined MID/RID
> values,  the Audio DMAC-peri-peri docs contain 2 separate tables for SRS and
> DRS values, so the DTS writer has to combine them manually.

Hmm... indeed
OK, I understand.
I fix it and send patch.

Best regards
---
Kuninori Morimoto
