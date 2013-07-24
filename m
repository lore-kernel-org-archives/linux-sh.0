From: Simon Horman <horms@verge.net.au>
Date: Wed, 24 Jul 2013 08:06:12 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo800eva-reference: fix compiler warning
Message-Id: <20130724080611.GA10027@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1361223490-20106-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1361223490-20106-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 19, 2013 at 06:02:16PM +0200, Guennadi Liakhovetski wrote:
> Fix the compiler warning:
> 
> arch/arm/mach-shmobile/board-armadillo800eva-reference.c:196:2: warning: initialization from incompatible pointer type [enabled by default]
> arch/arm/mach-shmobile/board-armadillo800eva-reference.c:196:2: warning: (near initialization for '__mach_desc_ARMADILLO800EVA_DT.restart') [enabled by default]
> 
> While at it also remove superfluous parenthesis.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Thanks, I have queued this up for v3.12 in the fixes2-for-v3.12 branch.
