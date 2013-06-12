From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Jun 2013 14:09:41 +0000
Subject: Re: [PATCH 02/06] ARM: shmobile: Add SCU boot function using argument
Message-Id: <20130612140940.GS32751@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130610091925.18944.68117.sendpatchset@w520>
 <20130610091946.18944.39252.sendpatchset@w520>
In-Reply-To: <20130610091946.18944.39252.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 10, 2013 at 06:19:46PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add a shmoible_boot_scu function that assumes that the base address
> of the SCU is passed in r0. This code is free from inline virtual
> to physical address conversion.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/headsmp-scu.S         |   13 +++++++++++++
>  arch/arm/mach-shmobile/include/mach/common.h |    1 +
>  2 files changed, 14 insertions(+)

Thanks, I have queued this up for v3.11 in the (new) cleanup-boot branch.
