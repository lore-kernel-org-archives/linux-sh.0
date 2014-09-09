From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 09 Sep 2014 06:33:58 +0000
Subject: Re: [PATCH 3/7 v3] mmc: use .multi_io_quirk on tmio_mmc
Message-Id: <87mwa97165.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
	<87bnqx78xr.wl%kuninori.morimoto.gx@gmail.com>
	<877g1l78v9.wl%kuninori.morimoto.gx@gmail.com>
	<CAPDyKFoVQjO7CLAQM-9DX12H5bOwwP6aqJtb=y3uRMNaWqV89A@mail.gmail.com>
	<87y4tt7ir2.wl%kuninori.morimoto.gx@gmail.com>
	<CAPDyKFo2mmDfdQFO0A87r1fpLHQQH5URW0TiW0D4bwN0zeP9Ag@mail.gmail.com>
In-Reply-To: <CAPDyKFo2mmDfdQFO0A87r1fpLHQQH5URW0TiW0D4bwN0zeP9Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>


Hi Ulf

> > sh_mobile_sdhi is based on tmio_mmc_xxx,
> > and sh_mobile_sdhi side needs this quirk.
> > I don't know original tmio_mmc_xxx HW.
> >
> > Of course we can add new flag to tmio driver,
> > but, it is same way as before ?
> 
> You are right, let's keep this patch as is, besides the "#include
> <linux/blkdev.h>", which isn't needed.
> 
> Sorry for the noise.

no problem
Please let me know if you need v4 patch

Best regards
---
Kuninori Morimoto
