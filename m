From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Nov 2013 07:21:13 +0000
Subject: Re: [PATCH 0/16] ARM: shmobile: SDHI support for r8a7790
Message-Id: <20131118072111.GG27935@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
 <87txffxofc.wl%kuninori.morimoto.gx@renesas.com>
 <87a9h6o2gi.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a9h6o2gi.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent <laurent.pinchart@ideasonboard.com>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org

On Thu, Nov 14, 2013 at 05:53:21PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> These are v2 of SDHI support for r8a7790.
> 
> Kuninori Morimoto (2):
>       ARM: shmobile: lager: add gpio/fixed regulator for SDHI
>       ARM: shmobile: lager: add SDHI0/2 support
> 
>  arch/arm/mach-shmobile/board-lager.c |  149 +++++++++++++++++++++++++++++++++-

Hi Morimoto-san,

I assume that these two patches depend on at least
some of the first 14 patches. Is that correct?
