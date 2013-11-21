From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Nov 2013 01:35:35 +0000
Subject: Re: [PATCH 5/6] ARM: shmobile: r8a7790: tidyup clock table order
Message-Id: <87y54iy1sr.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738msep7z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738msep7z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> > In this context I think the comment makes sense.
> 
>     I disagree because the clocks declared via CLKDEV_ICK_ID() are by nature 
> the same MSTP clocks as the others. This patch looks dangerously close to the 
> needless churn IMHO.

From MSTP grouping point of view, you are correct.
From PM-Runtime/Clock API point of view, this patch is sane.
