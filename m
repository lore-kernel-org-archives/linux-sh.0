From: Simon Horman <horms@verge.net.au>
Date: Tue, 06 Aug 2013 00:12:42 +0000
Subject: Re: [PATCH 4/4] ARM: shmobile: lager: add missing __initdata
Message-Id: <20130806001240.GH13274@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87r4ec98ph.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r4ec98ph.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 01, 2013 at 06:34:37PM -0700, Kuninori Morimoto wrote:
> This patch adds missing __initdata to driver data/resource
> which are used from platform_device_register_xxx()
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/board-lager.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, I have queued this up for v3.12 in the cleanup4 branch.
