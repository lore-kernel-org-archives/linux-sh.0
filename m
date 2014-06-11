From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 11 Jun 2014 07:40:09 +0000
Subject: Re: [PATCH 3/3 v3] ARM: shmobile: lager: add sound support on DT
Message-Id: <87k38nc2sg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87a99kj5q2.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a99kj5q2.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> On Wed, Jun 11, 2014 at 8:54 AM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> > +               compatible = "asahi-kasei,ak4643";
> 
> As Sergei already commented,
> Documentation/devicetree/bindings/vendor-prefixes.txt
> says
> 
>         ak      Asahi Kasei Corp.

I know, but,

grep asahi-kasei sound/soc/codecs/*
sound/soc/codecs/ak4104.c:      { .compatible = "asahi-kasei,ak4104", },
sound/soc/codecs/ak4554.c:      { .compatible = "asahi-kasei,ak4554" },
sound/soc/codecs/ak4642.c:      { .compatible = "asahi-kasei,ak4642",   .data = &ak4642_drvdata},
sound/soc/codecs/ak4642.c:      { .compatible = "asahi-kasei,ak4643",   .data = &ak4643_drvdata},
sound/soc/codecs/ak4642.c:      { .compatible = "asahi-kasei,ak4648",   .data = &ak4648_drvdata},
sound/soc/codecs/ak5386.c:      { .compatible = "asahi-kasei,ak5386", },

ak4642 driver can't probe by "ak";
My code is based on "code", not "document"

