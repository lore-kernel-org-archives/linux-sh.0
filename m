From: Simon Horman <horms@verge.net.au>
Date: Wed, 16 Oct 2013 06:53:07 +0000
Subject: Re: [PATCH 00/11] Marzen and Bockw defconfig updates
Message-Id: <20131016065307.GI15425@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1381389396-22000-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1381389396-22000-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 10, 2013 at 04:16:25PM +0900, Simon Horman wrote:
> Hi,
> 
> this series of defconfig updates aims to bring the bockw
> and marzen defconfigs more into line with the other shmobile
> defconfigs. It also allows the marzen and bockw boards
> to boot into a Debian armhf userspace, again in
> line with the defconfigs for other shmobile boards.
> 
> Simon Horman (11):
>   ARM: shmobile: bockw: Do not set command line in defconfig
>   ARM: shmobile: marzen: Do not set command line in defconfig
>   ARM: shmobile: bockw: Do not disable CONFIG_INOTIFY_USER in defconfig
>   ARM: shmobile: marzen: Do not disable CONFIG_INOTIFY_USER in defconfig
>   ARM: shmobile: bockw: Enable CONFIG_VFP in defconfig
>   ARM: shmobile: marzen: Enable CONFIG_VFP in defconfig
>   ARM: shmobile: bockw: Do not enable CONFIG_DEVTMPFS defconfig
>   ARM: shmobile: marzen: Do not enable CONFIG_DEVTMPFS defconfig
>   ARM: shmobile: bockw: Enable CONFIG_PACKET in defconfig
>   ARM: shmobile: marzen: Enable CONFIG_PACKET in defconfig
>   ARM: shmobile: marzen: Do not enable CONFIG_SMC911X in defconfig
> 
>  arch/arm/configs/bockw_defconfig  | 7 ++-----
>  arch/arm/configs/marzen_defconfig | 8 ++------
>  2 files changed, 4 insertions(+), 11 deletions(-)

I have queued up these patches.
