From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Nov 2010 08:26:53 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: mackerel: Add lost GPIO_FN_LCDD 18 - 23
Message-Id: <20101129082653.GA8482@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 29, 2010 at 03:19:52PM +0900, Kuninori Morimoto wrote:
> RGB24 bus needs 18-23 pin
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/board-mackerel.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
Applied to rmobile/mackerel, thanks.
