From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Jun 2013 14:10:01 +0000
Subject: Re: [PATCH 06/06] ARM: shmobile: Remove old SCU boot code
Message-Id: <20130612141000.GW32751@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130610091925.18944.68117.sendpatchset@w520>
 <20130610092025.18944.77279.sendpatchset@w520>
In-Reply-To: <20130610092025.18944.77279.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 10, 2013 at 06:20:25PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Remove shmobile_secondary_vector_scu now when all SCU enabled
> SMP platforms instead make use of shmobile_boot_scu. This
> removes two inline virtual to physical address conversions.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/headsmp-scu.S         |   22 +---------------------
>  arch/arm/mach-shmobile/include/mach/common.h |    1 -
>  2 files changed, 1 insertion(+), 22 deletions(-)

Thanks, I have queued this up for v3.11 in the (new) cleanup-boot branch.
