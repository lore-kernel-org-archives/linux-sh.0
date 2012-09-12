From: Stephen Boyd <sboyd@codeaurora.org>
Date: Wed, 12 Sep 2012 17:59:35 +0000
Subject: Re: [PATCH 2/2] arm: Add ARM ERRATA 782773 workaround
Message-Id: <5050CD87.4020800@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1347434097-7924-1-git-send-email-horms@verge.net.au>
 <1347434097-7924-3-git-send-email-horms@verge.net.au>
In-Reply-To: <1347434097-7924-3-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 09/12/12 00:14, Simon Horman wrote:
> @@ -1423,6 +1423,15 @@ config ARM_ERRATA_775420
>           deadlock. This workaround puts DSB before executing ISB at the
>           beginning of the abort exception handler.
>  
> +config ARM_ERRATA_782773
> +	bool "ARM errata: Updating a translation entry might cause an unexpected translation fault"
> +	depends on CPU_V7
> +	help
> +	  This option enables the workaround for the 782773 Cortex-A9 (all r0,
> +	  ,r2 and r3 revisions) erratum. It might cause MMU exception in case

Seems to be an extra comma here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

