From: Simon Horman <horms@verge.net.au>
Date: Mon, 11 Jun 2012 09:14:30 +0000
Subject: Re: [PATCH 19/27] ARM: shmobile: armadillo800eva: enable FSI-WM8978 sound
Message-Id: <20120611091429.GD22966@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87vciypkkg.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vciypkkg.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jun 10, 2012 at 08:57:23PM -0700, Kuninori Morimoto wrote:
> This patch enable sound support on CON11
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Tested-by: Simon Horman <horms@verge.net.au>

> ---
>  arch/arm/mach-shmobile/Kconfig                 |    1 +
>  arch/arm/mach-shmobile/board-armadillo800eva.c |   85 ++++++++++++++++++++++++
>  2 files changed, 86 insertions(+), 0 deletions(-)
