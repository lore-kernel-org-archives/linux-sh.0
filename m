From: Simon Horman <horms@verge.net.au>
Date: Fri, 28 Aug 2015 05:22:08 +0000
Subject: Re: [PATCH 04/17 v6][RFC] pinctrl: sh-pfc: Add R8A7795 PFC support
Message-Id: <20150828052205.GC6298@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87oai2b9rj.wl%kuninori.morimoto.gx@renesas.com>
 <87io8ab9jj.wl%kuninori.morimoto.gx@renesas.com>
 <CACRpkdY9-BO5XMhCmQP9M+9Uzd1r7GfbrA+0OHXxsy51YhCgeg@mail.gmail.com>
 <871tepefcp.wl%kuninori.morimoto.gx@renesas.com>
 <87io80c88b.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87io80c88b.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, YOSHIYUKI ITO <yoshiyuki.ito.ub@renesas.com>, Hisao Munakata <hisao.munakata.vt@renesas.com>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, TOSHIAKI KOMATSU <toshiaki.komatsu.ud@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>

On Fri, Aug 28, 2015 at 05:10:18AM +0000, Kuninori Morimoto wrote:
> 
> Hi Linus, Laurent
> 
> > > > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > > >
> > > > Add PFC support for the R8A7795 SoC including pin groups.
> > > > It is including EthernetAVB, DU, HDMI, MSOIF, SDHI, USB2.0, USB3.0
> > > >
> > > > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > > ---
> > > >> Linus W
> > > >
> > > > Becasue this is very large size patch, Maybe GPIO ML (SH-ARM ML too)
> > > > can't accept it (?). but please review it.
> > > >
> > > > v5 -> v6
> > > >
> > > >  - new patch
> > > 
> > > I would like Laurent to review it first of all of course, so include him
> > > on postings.
> > 
> > Oops. I thought I added Laurent, but it seems wrong.
> > Laurent, please review it.
> 
> This PFC driver is very large side, and it is difficult to review.
> I (and Magnus) dicided to create more simple one.
> I think it will be easy to review.
> So, please ignore current patch.

FWIW I think that is an excellent plan.
