From: Simon Horman <horms@verge.net.au>
Date: Mon, 06 Oct 2014 02:02:01 +0000
Subject: Re: [PATCH v2 0/2] ARM: shmobile: r8a7794/Cortex-A7 arch timer fix
Message-Id: <20141006020201.GE22040@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1410511926-9326-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1410511926-9326-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I am wondering about the status of this patchset.

On Fri, Sep 12, 2014 at 10:52:04AM +0200, Ulrich Hecht wrote:
> Hi!
> 
> Here's again the bit to get the arch timer working on the r8a7794 platform,
> this time without the secondary CPU initialization which we don't need
> anyway ATM for lack of SMP support.
> 
> CU
> Uli
> 
> 
> Changes since v1:
> - dumped secondary CPU intialization until we have SMP
> 
> 
> Hisashi Nakamura (1):
>   ARM: shmobile: r8a7794: Add arch_timer to device tree
> 
> Ulrich Hecht (1):
>   ARM: shmobile: rcar-gen2: Add CA7 arch_timer initialization for
>     r8a7794
> 
>  arch/arm/boot/dts/r8a7794.dtsi           |  8 ++++
>  arch/arm/mach-shmobile/setup-rcar-gen2.c | 72 ++++++++++++++++++++++----------
>  2 files changed, 57 insertions(+), 23 deletions(-)
> 
> -- 
> 1.8.4.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
