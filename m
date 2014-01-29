From: Simon Horman <horms@verge.net.au>
Date: Wed, 29 Jan 2014 12:38:23 +0000
Subject: Re: BockW 4th sound doesn't work on latest linus/master
Message-Id: <20140129123821.GC24573@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <878uu08tp8.wl%kuninori.morimoto.gx@gmail.com>
 <8761p48ry3.wl%kuninori.morimoto.gx@gmail.com>
 <20140129062942.GF23833@verge.net.au>
 <87wqhj6yvl.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87wqhj6yvl.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>

On Tue, Jan 28, 2014 at 11:17:06PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > Could you post a patch to revert the offending defconfig change.
> > 
> > Geert tells me that DEVTMPFS is needed for udev on Debian Jesse
> > and is also common in other arm defconfigs. So I think it should be
> > enabled.
> 
> Yes, it is needed for udev.
> I can send patch, but, according to git comment,
> the defconfig which doesn't have DEVTMPFS is not only BockW.
> Do you want "revert patch" ? or "add DEVTMPFS for all board patch" ?

I think the second option would be best.
