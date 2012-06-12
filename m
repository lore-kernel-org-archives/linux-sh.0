From: Simon Horman <horms@verge.net.au>
Date: Tue, 12 Jun 2012 01:31:48 +0000
Subject: Re: [PATCH 12/27] ARM: shmobile: r8a7740: add FSI parent clock support
Message-Id: <20120612013146.GA3557@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8762ayqz8r.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8762ayqz8r.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jun 10, 2012 at 08:55:04PM -0700, Kuninori Morimoto wrote:
> r8a7740 FSI can select its parent clock,
> and its selection is dependent on platform board.
> 
> In order to enable FSI parent selection from platform board,
> this patch adds its interface to clock framework.
> 
> This patch is based on v1.0 manual
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Tested-by: Simon Horman <horms@verge.net.au>

> ---
>  arch/arm/mach-shmobile/clock-r8a7740.c |   31 +++++++++++++++++++++++++++++++
>  1 files changed, 31 insertions(+), 0 deletions(-)
