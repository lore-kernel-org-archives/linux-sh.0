From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 28 Jan 2014 15:06:52 +0000
Subject: Re: mmc: sh_mobile_sdhi: DT update for R-Car
Message-Id: <52E7D59C.9000606@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>
Cc: Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

Hello.

On 01/28/2014 07:44 AM, Kuninori Morimoto wrote:

> Hi Chris

> These patches updates code for R-Car.
> Basically, these clarifies chip dependent settings
> inside driver, and, removed unneeded settings from dtsi file.
> These are based on latest linus/master branch
> (ba635f8cd20ebc7bddf1eb8e1f4eae28a034e916)

> Kuninori Morimoto (4):
>        mmc: SDHI: tidyup sh_mobile_sdhi_of_match position
>        mmc: SDHI: updata sh_mobile_sdhi_of_data for r8a7778
>        mmc: SDHI: updata sh_mobile_sdhi_of_data for r8a7779
>        mmc: SDHI: updata sh_mobile_sdhi_of_data for r8a7790

    s/updata/update/.

WBR, Sergei

