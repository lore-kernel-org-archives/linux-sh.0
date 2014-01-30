From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 30 Jan 2014 05:38:02 +0000
Subject: Re: mmc: sh_mobile_sdhi: DT update for R-Car
Message-Id: <87y51yghc9.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>
Cc: Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org


Hi Chris, Simon

> These patches updates code for R-Car.
> Basically, these clarifies chip dependent settings
> inside driver, and, removed unneeded settings from dtsi file.
> These are based on latest linus/master branch
> (ba635f8cd20ebc7bddf1eb8e1f4eae28a034e916)
> 
> Kuninori Morimoto (4):
>       mmc: SDHI: tidyup sh_mobile_sdhi_of_match position
>       mmc: SDHI: updata sh_mobile_sdhi_of_data for r8a7778
>       mmc: SDHI: updata sh_mobile_sdhi_of_data for r8a7779
>       mmc: SDHI: updata sh_mobile_sdhi_of_data for r8a7790
> 
>  arch/arm/boot/dts/r8a7778-bockw-reference.dts |    4 ++-
>  arch/arm/boot/dts/r8a7778.dtsi                |    6 ----
>  arch/arm/boot/dts/r8a7779.dtsi                |    8 -----
>  arch/arm/boot/dts/r8a7790.dtsi                |    4 ---
>  drivers/mmc/host/sh_mobile_sdhi.c             |   41 +++++++++++++++++--------
>  5 files changed, 31 insertions(+), 32 deletions(-)

These patches modify both mmc driver and sh-arm.
Should I separate these ?
Or Chris can apply these with Simon's Ack ?

Basically, modify both files are the best way,
but it is possible to separate

