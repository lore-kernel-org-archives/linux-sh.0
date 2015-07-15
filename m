From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 00:39:18 +0000
Subject: Re: [PATCH] ARM: multi_v7_defconfig: add Renesas DPCM Sound Card
Message-Id: <87lheiw92x.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mvyyw99t.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mvyyw99t.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch enables Renesas DPCM related sound card.
> It is used for...
>  - Sampline rate convert
>  - CTU/MIXer
> 
> Note: you need to enable these settings on DTS file
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Sorry, please ignore this patch.
I noticed that there is compile error on this patch

