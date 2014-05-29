From: Simon Horman <horms@verge.net.au>
Date: Thu, 29 May 2014 23:38:25 +0000
Subject: Re: [PATCH 0/3] ARM: shmobile: Add Core-Standby-state for Suspend to RAM
Message-Id: <20140529233825.GB15648@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <5386E089.3050003@renesas.com>
In-Reply-To: <5386E089.3050003@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 29, 2014 at 04:23:53PM +0900, keita kobayashi wrote:
> These patches add Core-Standby-state for Suspend to RAM support to the
> r8a7790/r8a7791 SoC. This patch series depend on previously posted patch.
> 	[PATCH] ARM: shmobile: r8a7791: SYSC setup code.
> 
> This patch series is based on renesas-devel-v3.15-rc7-20140526 tag

Thanks.

Please repost this series once that patch has been accepted
(I believe you need to post v2 of it to address some review of it.)

> 
> Keita Kobayashi (3):
>   ARM: shmobile: APMU: Add Core-Standby-state for Suspend to RAM
>   ARM: shmobile: r8a7790: Support Core-Standby for Suspend to RAM
>   ARM: shmobile: r8a7791: Support Core-Standby for Suspend to RAM
> 
>  arch/arm/mach-shmobile/include/mach/common.h |    2 +
>  arch/arm/mach-shmobile/platsmp-apmu.c        |   60 ++++++++++++++++++++++++--
>  arch/arm/mach-shmobile/smp-r8a7790.c         |    1 +
>  arch/arm/mach-shmobile/smp-r8a7791.c         |    1 +
>  4 files changed, 60 insertions(+), 4 deletions(-)
> 
> -- 
> 1.7.9.5
> 
