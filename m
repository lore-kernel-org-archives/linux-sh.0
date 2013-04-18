From: Simon Horman <horms@verge.net.au>
Date: Thu, 18 Apr 2013 14:00:25 +0000
Subject: Re: [PATCH] ARM: shmobile: BOCK-W: enable CONFIG_PM_RUNTIME in defconfig
Message-Id: <20130418140025.GN20929@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201304170303.46193.sergei.shtylyov@cogentembedded.com>
 <20130417101017.GW14496@n2100.arm.linux.org.uk>
 <516E8EF9.8030600@cogentembedded.com>
In-Reply-To: <516E8EF9.8030600@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Apr 17, 2013 at 04:00:57PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 17-04-2013 14:10, Russell King - ARM Linux wrote:
> 
> >>From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> 
> >>Enable CONFIG_PM_RUNTIME in 'bockw_defconfig' -- it's already used by TMU, SCI,
> >>I2C, and Ether drivers to control the clocks...
> 
> >>Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >>---
> >>The patch is atop of Simon's 'renesas.git' tree, 'renesas-next-20130416' tag.
> 
> >Maybe you should send it to Simon rather than me for initial merging, who
> >would presumably know if this is the right thing for this bockw platform?
> 
>    Blame scripts/get_maintainer.pl.
>    I think Simion will see the patch on the list anyway.

Somehow I missed it, but thanks to patchwork I now have it.
I will queue it up for v3.11.
