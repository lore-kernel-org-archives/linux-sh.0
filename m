From: Simon Horman <horms@verge.net.au>
Date: Wed, 17 Oct 2012 04:40:11 +0000
Subject: Re: [GIT PULL] Renesas ARM-based SoC fixes for v3.7
Message-Id: <20121017044011.GA27684@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1350448585-26403-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1350448585-26403-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Oct 17, 2012 at 01:36:23PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider the following fix for the KZM-A9-GT board for 3.6.

Sorry, cut-and paste error. The line above should read:

please consider the following fixes for 3.7.

> They both resolve fallout from recent IOMEM() changes.
> 
> ----------------------------------------------------------------
> The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:
> 
>   Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git fixes
> 
> for you to fetch changes up to 11f93576b0b50bf391ffafa544b85e541f5e59a5:
> 
>   ARM: shmobile: r8a7779: use __iomem pointers for MMIO (2012-10-16 08:58:56 +0900)
> 
> ----------------------------------------------------------------
> Kuninori Morimoto (2):
>       ARM: shmobile: armadillo800eva: __io abuse cleanup
>       ARM: shmobile: r8a7779: use __iomem pointers for MMIO
> 
>  arch/arm/mach-shmobile/board-armadillo800eva.c |    2 +-
>  arch/arm/mach-shmobile/clock-r8a7779.c         |   22 +++++++++++-----------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
