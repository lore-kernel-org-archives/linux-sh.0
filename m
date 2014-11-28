From: Simon Horman <horms@verge.net.au>
Date: Fri, 28 Nov 2014 00:18:46 +0000
Subject: Re: [PATCH 0/2] Fix legacy boards compilation breakage with DU
Message-Id: <20141128001846.GD30850@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1417101553-5233-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1417101553-5233-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, arm@kernel.org

[CCed Magnus, ARM SoC maintainers]

On Thu, Nov 27, 2014 at 05:19:11PM +0200, Laurent Pinchart wrote:
> Hello,
> 
> The DU driver has lost support for platform data, resulting in a compilation
> breakage for the legacy Marzen and Lager board files that managed to keep
> under the radar until now.
> 
> As the multiplatform boards should be used instead, drop support for DU in the
> legacy Marzen and Lager boards.
> 
> Simon, this is required to fix a compilation breakage in the drm-next branch.
> I'm sorry for not catching it earlier :-/ How would you like this to go in ?
> Could the patches be applied to the DRM tree ? They seem to apply cleanly to
> both drm-next and your latest devel branch.
> 
> Laurent Pinchart (2):
>   ARM: shmobile: lager: Remove DU platform device
>   ARM: shmobile: marzen: Remove DU platform device
> 
>  arch/arm/mach-shmobile/board-lager.c  | 58 -----------------------------------
>  arch/arm/mach-shmobile/board-marzen.c | 58 -----------------------------------

Yes, I think that should be fine as these fines are in maintenance mode and
the only recent change I see to them is to modify the FSF address, which
seems far away from the hunks in this patch-set.

In other words, I think the chance of conflicts is small and I am fine with
these changes going through the DRM tree if that is where the breakage
manifests.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

I am of course, happy to take them if the DRM maintainer(s) prefer
me to.



