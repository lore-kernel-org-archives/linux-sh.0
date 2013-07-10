From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Jul 2013 01:14:05 +0000
Subject: Re: [PATCH 04/04] ARM: shmobile: Remove unused mach/dma.h
Message-Id: <20130710011404.GO32603@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130709103944.1891.67462.sendpatchset@w520>
 <20130709104016.1891.68682.sendpatchset@w520>
In-Reply-To: <20130709104016.1891.68682.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jul 09, 2013 at 07:40:16PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Remove mach-shmobile mach/dma.h since it only
> seems to be used on non-mach-shmobile platforms.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/include/mach/dma.h |    1 -
>  1 file changed, 1 deletion(-)

Thanks, I have queued this up for v3.12 in the cleanup branch.
It should appear in renesas-next-20130710
