From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 15 Jul 2014 11:58:21 +0000
Subject: Re: [PATCH] ARM: shmobile: genmai: remove defconfig
Message-Id: <3624228.NbiLenVez0@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1405409364-23378-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1405409364-23378-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

Thank you for the patch.

On Tuesday 15 July 2014 16:29:24 Simon Horman wrote:
> The genmai board code is scheduled for removal and once
> that occurs the defconfig will be of no use. Remove it.
> 
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Now that the MTU2 boot issue has been solved (thank you for tracking it down), 
am I correct to assume that all timer patches, the genmai board file removal 
series and this patch will make it to v3.17 ?

> ---
>  arch/arm/configs/genmai_defconfig | 122 -----------------------------------
> 1 file changed, 122 deletions(-)
>  delete mode 100644 arch/arm/configs/genmai_defconfig

-- 
Regards,

Laurent Pinchart

