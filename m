From: Simon Horman <horms@verge.net.au>
Date: Thu, 03 Oct 2013 04:14:30 +0000
Subject: Re: [PATCH 4/4 v2] ARM: shmobile: bockw: add SMSC support on DTS
Message-Id: <20131003041428.GG7925@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87r4f7uoxx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r4f7uoxx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 02, 2013 at 01:34:07AM -0700, Kuninori Morimoto wrote:
> This patch enables INTC IRQ and SMSC on BockW board via DT.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
> 
>  - patch was splited, only dts
> 
>  arch/arm/boot/dts/r8a7778-bockw-reference.dts |   27 ++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)


Thanks, I have queued this up in the dt3 branch.
It should make it into v3.13 but if not I'll rename the branch
dt after rebasing it on v3.13-rcX which will then be targeted at v3.14.
