From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 11 Nov 2015 23:54:07 +0000
Subject: Re: [PATCH] i2c: rcar: make sure clocks are on when doing hw init
Message-Id: <87egfww10l.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446146356-26166-1-git-send-email-wsa@the-dreams.de>
	<87io5pgrcr.wl%kuninori.morimoto.gx@renesas.com>
	<20151111082606.GA24344@katana>
	<87wptoewvw.wl%kuninori.morimoto.gx@renesas.com>
	<20151111163403.GA1527@katana>
In-Reply-To: <20151111163403.GA1527@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>


Hi Wolfram

> > On SH-Mobile case, it automatically power-off:ed if all driver
> > user was gone.
> 
> It does that without calling some callback?

Do you mean you can call init() in callback ?
I don't care detail of design. But my concern was that
register value might be disappear during many get/put if
power-domain was implemented

