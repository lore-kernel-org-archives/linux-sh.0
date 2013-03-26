From: Simon Horman <horms@verge.net.au>
Date: Tue, 26 Mar 2013 12:01:13 +0000
Subject: Re: [PATCH 0/2] PFC compilation fixes for v3.10
Message-Id: <20130326120110.GA20892@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1364264415-6020-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1364264415-6020-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 26, 2013 at 03:20:13AM +0100, Laurent Pinchart wrote:
> Hello,
> 
> Here are two fixes for compilation warning and error introduced in the PFC
> patches scheduled for v3.10.
> 
> Simon, could you please pick these two patches and push them upstream ?

Sure, will do.

> Laurent Pinchart (2):
>   sh-pfc: Fix compiler warning when BUG()
>   sh: sh7269: Fix compilation by adding missing includes
> 
>  arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c | 2 ++
>  drivers/pinctrl/sh-pfc/core.c           | 1 +
>  2 files changed, 3 insertions(+)
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
