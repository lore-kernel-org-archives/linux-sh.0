From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Aug 2015 23:50:08 +0000
Subject: Re: [PATCH 10/17 v6][RFC] arm64: renesas: add SalvatorX board support on DTS
Message-Id: <87h9ntbk19.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878u96b9ei.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878u96b9ei.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > +&pfc {
> > +	scif2_pins: scif2 {
> > +		renesas,groups = "scif2_data";
> > +		renesas,function = "scif2";
> > +       };
> 
> The line above uses spaces instead of a tab for indentation.

Thanks
Will fix in v7
