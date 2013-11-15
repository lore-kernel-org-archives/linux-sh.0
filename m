From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 15 Nov 2013 00:43:40 +0000
Subject: Re: [PATCH 0/16] ARM: shmobile: SDHI support for r8a7790
Message-Id: <87d2m2o5om.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
	<87txffxofc.wl%kuninori.morimoto.gx@renesas.com>
	<2008878.YfHkJYy4No@avalon>
In-Reply-To: <2008878.YfHkJYy4No@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org


Hi Laurent, Simon

> > These are SDHI support for r8a7790.
> > 
> > Kuninori Morimoto (14):
> >       ARM: shmobile: lager: add SDHI0/2 support
> >       ARM: shmobile: lager: use gpio/fixed regulator for SDHI
> 
> As the second patches fixes a problem in the first one, I'd like to split them 
> differently. Could you please submit a first patch that adds the regulators, 
> and a second patch that adds SDHI0/2 support using the regulators ?

OK, will do in v2 patches.

> Simon

I will resend these 2 patch-set. (= not all 16 patches)
