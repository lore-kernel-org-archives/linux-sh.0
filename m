From: Simon Horman <horms@verge.net.au>
Date: Thu, 03 Oct 2013 04:34:13 +0000
Subject: Re: [PATCH 3/4 v2] ARM: shmobile: bockw: add SMSC support on reference
Message-Id: <20131003043411.GR7925@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87eh84ysvj.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87eh84ysvj.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 02, 2013 at 01:33:36AM -0700, Kuninori Morimoto wrote:
> This patch enables INTC IRQ, and SMSC IRQ.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
> 
>  - patch was splited, only -reference.c
> 
>  arch/arm/mach-shmobile/board-bockw-reference.c |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Thanks, I have queued this up in the boards3 branch.
It should make it into v3.13 but if not I'll rename the branch
soc after rebasing it on v3.13-rcX which will then be targeted at v3.14.
