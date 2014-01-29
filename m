From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 29 Jan 2014 07:17:06 +0000
Subject: Re: BockW 4th sound doesn't work on latest linus/master
Message-Id: <87wqhj6yvl.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878uu08tp8.wl%kuninori.morimoto.gx@gmail.com>
	<8761p48ry3.wl%kuninori.morimoto.gx@gmail.com>
	<20140129062942.GF23833@verge.net.au>
In-Reply-To: <20140129062942.GF23833@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Mark Brown <broonie@kernel.org>, Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>


Hi Simon

> Could you post a patch to revert the offending defconfig change.
> 
> Geert tells me that DEVTMPFS is needed for udev on Debian Jesse
> and is also common in other arm defconfigs. So I think it should be
> enabled.

Yes, it is needed for udev.
I can send patch, but, according to git comment,
the defconfig which doesn't have DEVTMPFS is not only BockW.
Do you want "revert patch" ? or "add DEVTMPFS for all board patch" ?

Best regards
---
Kuninori Morimoto
