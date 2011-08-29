From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Aug 2011 07:27:30 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: clock-sh73a0: tidyup CKSCR main clock selecter
Message-Id: <20110829072730.GG31809@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pmxozyxra.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pmxozyxra.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 26, 2011 at 12:27:45AM -0700, Kuninori Morimoto wrote:
> MAINCKSEL is [29:28], not [27:24]
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/clock-sh73a0.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
Applied, thanks.
