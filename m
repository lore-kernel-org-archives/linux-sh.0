From: Simon Horman <horms@verge.net.au>
Date: Mon, 11 Jun 2012 08:00:27 +0000
Subject: Re: [PATCH 03/27] ARM: shmobile: shareing extra gpio setting functions
Message-Id: <20120611080026.GH30048@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87ipeyqzdr.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ipeyqzdr.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jun 10, 2012 at 08:52:03PM -0700, Kuninori Morimoto wrote:
> Current gpio frame work doesn't have the method to control
> just pull up/down/free, but some SH-ARM boards need such kind of operation,
> and some boards already have such functions on each code.
> 
> This patch shares extra gpio method, and reduced a waste of code on SH-ARM.
> But these functions should be replaced by correct
> gpio function in the future.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Tested-by: Simon Horman <horms@verge.net.au>

> ---
>  arch/arm/mach-shmobile/board-ap4evb.c      |   19 +--------------
>  arch/arm/mach-shmobile/board-g4evm.c       |   18 ---------------
>  arch/arm/mach-shmobile/board-mackerel.c    |   30 +------------------------
>  arch/arm/mach-shmobile/include/mach/gpio.h |   32 ++++++++++++++++++++++++++++
>  4 files changed, 36 insertions(+), 63 deletions(-)
