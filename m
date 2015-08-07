From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 07 Aug 2015 00:13:25 +0000
Subject: Re: [PATCH 13/13 v4][RFC] Local: arm64: renesas: add SalvatorX board support on DTS
Message-Id: <87bnekdkmc.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87egjgyh6d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87egjgyh6d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert


> > +       aliases {
> > +               serial0 = &scif2;
> 
> Mapping 0 to 2?
(snip)
> |        stdout-path = "/path/to/scifa0:115200n8"
> |
> |        stdout-path = "serial0:115200n8"
> 
> I haven't tried that yet, but we may want to start doing The Right Thing (tm)
> with Gen3.

I will try it if I have chance to HW access.
otherwise, my v5 will be just tidyups.

Best regards
---
Kuninori Morimoto
