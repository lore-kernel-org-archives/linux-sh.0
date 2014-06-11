From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 11 Jun 2014 08:40:06 +0000
Subject: Re: [alsa-devel] "ak" vs "asahi-kasei" (was: Re: [PATCH 3/3 v3] ARM: shmobile: lager: add sound supp
Message-Id: <539815E6.2050304@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWTVBjFzA9L9Eqpq_2Xi9_NHkOCLrb_UjK611SBfwnc=Q@mail.gmail.com> <87ioo7c0g5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ioo7c0g5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus <magnus.damm@gmail.com>, Simon <horms@verge.net.au>

On 11/06/14 09:30, Kuninori Morimoto wrote:
> 
> Hi Geert
> 
>>> grep asahi-kasei sound/soc/codecs/*
>>> sound/soc/codecs/ak4104.c:      { .compatible = "asahi-kasei,ak4104", },
>>> sound/soc/codecs/ak4554.c:      { .compatible = "asahi-kasei,ak4554" },
>>> sound/soc/codecs/ak4642.c:      { .compatible = "asahi-kasei,ak4642",   .data = &ak4642_drvdata},
>>> sound/soc/codecs/ak4642.c:      { .compatible = "asahi-kasei,ak4643",   .data = &ak4643_drvdata},
>>> sound/soc/codecs/ak4642.c:      { .compatible = "asahi-kasei,ak4648",   .data = &ak4648_drvdata},
>>> sound/soc/codecs/ak5386.c:      { .compatible = "asahi-kasei,ak5386", },
>>>
>>> ak4642 driver can't probe by "ak";

Should we add ak, as well?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
