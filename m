From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Dec 2015 23:07:38 +0000
Subject: Re: [PATCH 0/3] ARM: shmobile: defconfig: Misc updates
Message-Id: <20151211230737.GB6496@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449760562-26795-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449760562-26795-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Dec 10, 2015 at 04:15:59PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> Here are a few updates for the shmobile defconfig.
> If these are accepted, I'll send out equivalent updates for
> multi_v7_defconfig.
> 
> Geert Uytterhoeven (3):
>   ARM: shmobile: defconfig: Drop useless CONFIG_USB_RCAR_PHY=y
>   ARM: shmobile: defconfig: Enable missing support based on DTSes
>   ARM: shmobile: defconfig: Enable frame buffer console for
>     armadillo800eva
> 
>  arch/arm/configs/shmobile_defconfig | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Thanks, I have queued these up.
