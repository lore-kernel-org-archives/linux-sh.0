From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 05 Jan 2015 09:15:34 +0000
Subject: Re: [PATCH 8/9] mmc: sh_mobile_sdhi: remove .init/.cleanup
Message-Id: <87d26toaeg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87zj9xogln.wl%kuninori.morimoto.gx@renesas.com>
	<87oaqdoghr.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdVTQ1nsZYb7U07MaAt0OcmxKEBoD35NbP9TM7SE97tcQQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVTQ1nsZYb7U07MaAt0OcmxKEBoD35NbP9TM7SE97tcQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>


Hi Geert

Thank you for your review.

> > -static void sh_mobile_sdhi_cd_wakeup(const struct platform_device *pdev)
> > -{
> > -       mmc_detect_change(platform_get_drvdata(pdev), msecs_to_jiffies(100));
> > -}
> > -
> > -static const struct sh_mobile_sdhi_ops sdhi_ops = {
> > -       .cd_wakeup = sh_mobile_sdhi_cd_wakeup,
> > -};
> > -
> 
> Is this intentional?
> 
> While .cd_wakeup looks indeed unused, you forgot to mention its removal in
> the patch description.

Because, sdhi_ops (and .cd_wakeup) is used from .init
OK, I will explain about it in patch description in v2
Thanks

Best regards
---
Kuninori Morimoto
