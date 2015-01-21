From: Simon Horman <horms@verge.net.au>
Date: Wed, 21 Jan 2015 01:59:39 +0000
Subject: Re: [PATCH 00/03] ARM: shmobile: Minor header cleanup
Message-Id: <20150121015937.GD30598@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150120115750.11479.95109.sendpatchset@little-apple>
In-Reply-To: <20150120115750.11479.95109.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jan 20, 2015 at 08:57:50PM +0900, Magnus Damm wrote:
> ARM: shmobile: Minor header cleanup
> 
> [PATCH 01/03] ARM: shmobile: Remove mach/system.h
> [PATCH 02/03] ARM: shmobile: Remove mach/clkdev.h
> [PATCH 03/03] ARM: shmobile: Remove mach/uncompress.h
> 
> Rework the mach-shmobile code a bit more to allow
> removing the files system.h, clkdev.h and uncompress.h
> from arch/arm/mach-shmobile/include/mach/
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Thanks, I have queued this up for v3.21 with Laurent and Geert's Acks.

> ---
> 
>  Built on top of renesas-devel-20150119-v3.19-rc5
> 
>  arch/arm/Kconfig                                 |    1 -
>  arch/arm/Kconfig.debug                           |    3 ++-
>  arch/arm/mach-shmobile/clock.c                   |   11 -----------
>  arch/arm/mach-shmobile/include/mach/clkdev.h     |    7 -------
>  arch/arm/mach-shmobile/include/mach/system.h     |   11 -----------
>  arch/arm/mach-shmobile/include/mach/uncompress.h |   19 -------------------
>  6 files changed, 2 insertions(+), 50 deletions(-)
> 
