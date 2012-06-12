From: Simon Horman <horms@verge.net.au>
Date: Tue, 12 Jun 2012 01:30:47 +0000
Subject: Re: [PATCH 15/27] ARM: shmobile: r8a7740: add DMAEngine support for SDHI
Message-Id: <20120612013045.GG16346@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <871ulmqz6l.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871ulmqz6l.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jun 10, 2012 at 08:56:22PM -0700, Kuninori Morimoto wrote:
> Current shdmac can support SDHI DMAC on r8a7740.
> This support reduce CPU load when SDHI access.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Tested-by: Simon Horman <horms@verge.net.au>

> ---
>  arch/arm/mach-shmobile/include/mach/r8a7740.h |    6 +++++
>  arch/arm/mach-shmobile/setup-r8a7740.c        |   30 +++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 0 deletions(-)
