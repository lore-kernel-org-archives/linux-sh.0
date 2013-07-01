From: Simon Horman <horms@verge.net.au>
Date: Mon, 01 Jul 2013 01:36:28 +0000
Subject: Re: [PATCH] ARM: shmobile: Update romImage to relocate appended DTB
Message-Id: <20130701013627.GD14567@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130626234807.11425.24645.sendpatchset@w520>
In-Reply-To: <20130626234807.11425.24645.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jun 27, 2013 at 08:48:07AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Instead of relying of MACH_TYPE for board identification,
> update the romImage code to relocate an appended DTB to
> the beginning of RAM. This implementation is independent
> of ARM_APPENDED_DTB, this because it is necessary to copy
> the DTB to memory so the kernel can access it.
> 
> Without this patch Mackerel does not boot via the Mask ROM
> over USB (r_usb_boot) - this since non-DT boot was broken
> ages ago in commit:
> 
> 0ce53cd ARM: mach-shmobile: Use DT_MACHINE for mackerel
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against renesas-next-20130620
> 
>  arch/arm/boot/compressed/head-shmobile.S    |   43 ++++++++++++++++++++++++---
>  arch/arm/mach-shmobile/include/mach/zboot.h |    2 -
>  2 files changed, 39 insertions(+), 6 deletions(-)

Thanks, I have queued this up in the boot-cleanup branch.
