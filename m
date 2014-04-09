From: Simon Horman <horms@verge.net.au>
Date: Wed, 09 Apr 2014 00:24:33 +0000
Subject: Re: [PATCH 00/02] ARM: shmobile: r8a7790 8-core boot prototype
Message-Id: <20140409002430.GB2694@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140408124758.9773.14458.sendpatchset@w520>
In-Reply-To: <20140408124758.9773.14458.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 08, 2014 at 09:47:58PM +0900, Magnus Damm wrote:
> ARM: shmobile: r8a7790 8-core boot prototype
> 
> [PATCH 01/02] ARM: shmobile: Multicluster APMU prototype support
> [PATCH 02/02] ARM: shmobile: r8a7790 CCI configuration
> 
> Prototype patches to allow 8-core boot on r8a7790. The first patch
> unlocks multicluster support to allo SMP boot of all CPU cores, and
> the second initializes the CCI-400 hardware.

Hi Magnus,

I applied these patches on top of renesas-devel-v3.14-20140408,
compiled using the shmobile_defconfig, and booted a Lager board.
I was expecting to see 8 cores in /proc/cpuinfo but I only see 4.

Are my expectations wrong or am I missing something?

> Not for upstream merge.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Applies on top of renesas-devel-v3.14-20140408
> 
>  arch/arm/mach-shmobile/platsmp-apmu.c |   16 ++++++++++++++--
>  arch/arm/mach-shmobile/smp-r8a7790.c  |   15 +++++++++++++++
>  2 files changed, 29 insertions(+), 2 deletions(-)
> 
