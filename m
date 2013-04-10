From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Apr 2013 00:41:52 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: R8A7778: fix Ether device name
Message-Id: <20130410004151.GC2462@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201304092147.51621.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304092147.51621.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Apr 09, 2013 at 09:47:51PM +0400, Sergei Shtylyov wrote:
> While recasting the commit "ARM: shmobile: R8A7778: add Ether support", I made a
> typo in the platform device's name: used underscore instead of hyphen. 
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is atop of the 'renesas-next-20130410' tag of the 'renesas.git' tree.

Thanks, queued up in the soc-r7a7778 branch.
