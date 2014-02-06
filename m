From: Simon Horman <horms@verge.net.au>
Date: Thu, 06 Feb 2014 07:06:19 +0000
Subject: Re: [PATCH 00/04] ARM: shmobile: r8a7790 SYSC, SCU and CCI setup code
Message-Id: <20140206070616.GH17591@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140115122539.9437.63968.sendpatchset@w520>
In-Reply-To: <20140115122539.9437.63968.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jan 15, 2014 at 09:25:39PM +0900, Magnus Damm wrote:
> ARM: shmobile: r8a7790 SYSC, SCU and CCI setup code
> 
> [PATCH 01/04] ARM: shmobile: r8a7790 SYSC setup code
> [PATCH 02/04] ARM: shmobile: r8a7790 CA7-SCU enablement
> [PATCH 03/04] ARM: shmobile: r8a7790 CA15-SCU enablement

Thanks, I have queued up the above three patches.

> [PATCH 04/04] ARM: shmobile: r8a7790 CCI configuration

This one seems not quite ready.

> 
> Add r8a7790 specific SYSC, SCU and CCI setup code.
> 
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
> [damm@opensource.se: Converted to use broken out SYSC code]
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against renesas.git tag renesas-devel-v3.13-rc8-20140115,
>  also requires "[PATCH] ARM: shmobile: Break out R-Car SYSC PM code"
> 
>  arch/arm/mach-shmobile/Makefile               |    1 
>  arch/arm/mach-shmobile/include/mach/r8a7790.h |    1 
>  arch/arm/mach-shmobile/pm-r8a7790.c           |   45 +++++++++++++++++++++++++
>  arch/arm/mach-shmobile/smp-r8a7790.c          |   32 +++++++++++++++++
>  4 files changed, 79 insertions(+)
> 
