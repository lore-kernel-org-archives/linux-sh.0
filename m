From: kuninori.morimoto.gx@renesas.com
Date: Mon, 11 Jun 2012 09:57:17 +0000
Subject: Re: [PATCH 18/27] ARM: shmobile: armadillo800eva: enable camera
Message-Id: <87fwa2p3wm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wr3epkkt.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wr3epkkt.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > This patch enable camera support on CON1
> 
> Hi Morimoto-san,
> 
> could you suggest a simple way to test this, preferably from the command line?

I'm using mplayer.

mplayer -tv widthd0:heightH0 tv:// -tv outfmt=uyvy -tv device=/dev/video0
