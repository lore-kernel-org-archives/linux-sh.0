From: Simon Horman <horms@verge.net.au>
Date: Fri, 15 Mar 2013 15:41:07 +0000
Subject: Re: [ANNOUNCE] Renesas branch refresh
Message-Id: <20130315154107.GC16561@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130313154630.GB2755@verge.net.au>
In-Reply-To: <20130313154630.GB2755@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 13, 2013 at 04:46:31PM +0100, Simon Horman wrote:
> Hi,
> 
> I would like to announce that I have pushed fresh branches to
> the renesas tree on kernel.org which for the basis of what I intend
> to request arm-soc to pull for v3.10.
> 
> The new/rebased branches are as follows:
> 
> * next-for-v3.10
> 
>   A merge of fixes, defconfig, soc, pinmux and boards.
>   I have not named this next at this time primarily because
>   it includes the pinmux branch which is based on a branch of
>   Linus Walleij's linux-pinctrl tree and I would like his approval
>   to use that in linux-next and request it to be pulled into arm-soc first.
> 
> * fixes
> 
>   Critical fixes targeted at inclusion in v3.9.
>   Based on v3.9-rc1.
> 
> * defconfig
> 
>   defconfig changes.
>   Based on v3.9-rc2.
> 
> * soc
> 
>   SoC changes.
>   Based on v3.9-rc2.
> 
> * pinmux
> 
>   pinmux changes, a.k.a Laurent's work
>   Based on pinmux-base, a merge of: fixes and the devel branch of
>   Linus Walleij's linux-pinctrl tree on kernel.org

Laurent has rebased his tree and I have re-pushed the pinmux branch
accordingly.

> * boards
> 
>   Branch for board changes.
>   Based on boards-base, a merge of the pinmux and soc branches.

I have rebased this on the fresh pinmux branch.

> 
> 
> Old/unmodified branches. Not targeted at inclusion in arm-soc at this time.
> 
> * next
> 
>   This is present-in linux-next
>   It is based on v3.8-rc3.
>   I intend to replace it with next-for-v3.10 in the near future.

I have now pushed a rebased version of this branch as next
and it should appear in linux-next in the not to distant future.

> 
> * topic/*
> 
>   These are based on v3.8-rc3.
>   The only ones that still seem relevant are:
>   * topic/intc-of
>   * topic/r-car-du-drm
>   * topic/sh_eth
>   I intend the rebase the branches listed immediately above and
>   remove the rest. I do not believe there is any need for
>   topic/all+next at this point and I plan to remove it too.

I have removed all the topic/branches other than those listed with a '*'
above. The rebase of those branches is still pending.

> Deleted branches:
> 
> * boards3: Rebased and renamed boards
> * soc5: Rebased and renamed soc
> * pfc: Included in v3.9-rc2
> * boards-kzm9g-reference: Merged into soc and boards branches
