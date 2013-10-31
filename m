From: Simon Horman <horms@verge.net.au>
Date: Thu, 31 Oct 2013 09:30:39 +0000
Subject: Re: Question about r8a7779 ether
Message-Id: <20131031093034.GA24672@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvrhq143.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvrhq143.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 31, 2013 at 01:46:24AM -0700, Kuninori Morimoto wrote:
> 
> Hi
> 
> You know, we are removing r8a7779_add_xxx_device()
> from setup-r8a7779.
> When I cleaned these functions from setup-r8a7779,
> if my memory was correct, Sergei requested not to clean up
> r8a7779_add_ether_device(), since he sends patch for marzen.
> 
> But current marzen still doesn't use it.
> I'm checking renesas-devel-v3.12-rc7-20131030 tag.
> According to git log, r8a7779_add_ether_device() was added Apr 2013,
> and today, Nov 2013.

Its still October, just :^)

> Does Marzen need it ?
> If yes, who has this patch ? or what is current status of it ?
> 
> No one is using it in this 6 month.
> (and normal marzen board doesn't have sh_eth implement).
> Can I remove it anyway ?
> 
> r8a7779_add_ether_device() was added by this commit

From my POV it sounds reasonable to remove it.

> 
> dace48d04dee46a3409d5e13cd98031522e46377
> Author: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Date:   Thu Apr 4 18:53:50 2013 +0000
> 
>     ARM: shmobile: R8A7779: add Ether support
>     
>     Add Ether clock and platform device for R8A7779 SoC; add a function to register
>     this device with board-specific platform data.
>     
>     Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>     Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>     Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
