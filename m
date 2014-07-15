From: Simon Horman <horms@verge.net.au>
Date: Tue, 15 Jul 2014 11:35:11 +0000
Subject: Re: [PATCH 0/3] ARM: shmobile: r7s72100: Remove legacy board support
Message-Id: <20140715113459.GA25333@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404318218-4732-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1404318218-4732-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 02, 2014 at 06:23:35PM +0200, Laurent Pinchart wrote:
> Hello,
> 
> Now that all features supported by the Genmai legacy and reference board files
> are supported using DT boot on a multiplatform kernel, remove support for the
> Genmai board code and legacy (non multiplatform) r7s72100 code.
> 
> This patch set is based on top of and depends on the Genmai MTU2 DT patch
> ("ARM: shmobile: genmai-reference: Enable MTU2 in device tree").

As reported elsewhere I am having a bit of trouble with the dependencies
for this series so I have dropped it for now.

> 
> Laurent Pinchart (3):
>   ARM: shmobile: r7s72100: genmai: Remove reference board file
>   ARM: shmobile: r7s72100: genmai: Remove legacy board file
>   ARM: shmobile: r7s72100: Remove legacy board support
> 
>  arch/arm/mach-shmobile/Kconfig                  |  17 --
>  arch/arm/mach-shmobile/Makefile                 |   3 -
>  arch/arm/mach-shmobile/board-genmai-reference.c |  35 ----
>  arch/arm/mach-shmobile/board-genmai.c           | 174 ------------------
>  arch/arm/mach-shmobile/clock-r7s72100.c         | 231 ------------------------
>  arch/arm/mach-shmobile/r7s72100.h               |   6 -
>  arch/arm/mach-shmobile/setup-r7s72100.c         |   2 -
>  7 files changed, 468 deletions(-)
>  delete mode 100644 arch/arm/mach-shmobile/board-genmai-reference.c
>  delete mode 100644 arch/arm/mach-shmobile/board-genmai.c
>  delete mode 100644 arch/arm/mach-shmobile/clock-r7s72100.c
>  delete mode 100644 arch/arm/mach-shmobile/r7s72100.h
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
