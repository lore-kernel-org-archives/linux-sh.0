From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Apr 2013 00:42:33 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: R8A7779: fix Ether device name
Message-Id: <20130410004233.GD2462@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201304092149.00465.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304092149.00465.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Apr 09, 2013 at 09:48:59PM +0400, Sergei Shtylyov wrote:
> While recasting the commit "ARM: shmobile: R8A7779: add Ether support", I made a
> typo in the platform device's name: used underscore instead of hyphen. 
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is atop of the 'renesas-next-20130410' tag of the 'renesas.git' tree.
> 
>  arch/arm/mach-shmobile/setup-r8a7779.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, queued up in the soc-r8a7779 branch.
