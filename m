From: Simon Horman <horms@verge.net.au>
Date: Tue, 12 Jun 2012 01:32:02 +0000
Subject: Re: [PATCH 11/27] ARM: shmobile: r8a7740: add CEU clock support
Message-Id: <20120612013200.GB3557@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <877gveqz9j.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877gveqz9j.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jun 10, 2012 at 08:54:35PM -0700, Kuninori Morimoto wrote:
> It is required from sh_mobile_ceu_camera driver.
> This patch is based on v1.0 manual
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Tested-by: Simon Horman <horms@verge.net.au>

> ---
>  arch/arm/mach-shmobile/clock-r8a7740.c |   23 ++++++++++++++++++++++-
>  1 files changed, 22 insertions(+), 1 deletions(-)
