From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 28 Mar 2013 08:40:14 +0000
Subject: Re: pinmux missing from next in renesas tree
Message-Id: <3891776.FUARFIdxEg@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20130328003634.GF20736@verge.net.au>
In-Reply-To: <20130328003634.GF20736@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Thursday 28 March 2013 09:36:34 Simon Horman wrote:
> Unfortunately I forgot to merge pinmux into the next branch
> I pushed last night and tagged as renesas-next-20130327.
> 
> I have re-pushed and re-taged with pinmux merged.
> And also pushed pinmux which was one patch behind my local version.
> 
> For reference the relevant commit ids are:
> 
> next, renesas-next-20130327: 3f9904f90ec7729c8ac0bc554fed67d4f9d5bd59
> 			     (Merge branch 'pinmux' into next)
> pinmux: 5ae81435c987e2ef071452d438770865814e8390
>         (sh-pfc: r8a7779: Split DU input and output pixel clocks)

Thanks a lot.

I've rebased all my branches on top of renesas-next-20130328 and there's no 
patch missing except for the "[PATCH 0/3] sh-pfc: r8a7779: Improve readability 
with a new macro" series that will need a v2 anyway.

I've also successfully test that tag with the DU driver on the Marzen board.

-- 
Regards,

Laurent Pinchart

