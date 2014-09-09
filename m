From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 09 Sep 2014 02:45:46 +0000
Subject: Re: [PATCH 0/7 v3] mmc: remove MMC_CAP2_NO_MULTI_READ flags
Message-Id: <87sik17bqg.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
	<87bnqx78xr.wl%kuninori.morimoto.gx@gmail.com>
	<20140909024310.GE31320@verge.net.au>
In-Reply-To: <20140909024310.GE31320@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>


Hi Simon

> > Kuninori Morimoto (7):
> >       mmc: add .multi_io_quirk callback for multi I/O HW bug
> >       mmc: use .multi_io_quirk on omap_hsmmc
> >       mmc: use .multi_io_quirk on tmio_mmc
> >       mmc: use .multi_io_quirk on sh_mobile
> >       ARM: shmobile: remove MMC_CAP2_NO_MULTI_READ from koelsch
> >       ARM: shmobile: remove MMC_CAP2_NO_MULTI_READ from lager
> 
> Hi Morimoto-san,
> 
> could you let me know about the dependencies for the above two patches?

These have deep dependencies.
"ARM: shmobile: remove xxx" patches are based on 1) - 4) patches,
and, it is required to last patch.

Best regards
---
Kuninori Morimoto
