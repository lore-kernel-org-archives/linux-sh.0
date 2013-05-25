From: Simon Horman <horms@verge.net.au>
Date: Sat, 25 May 2013 00:58:43 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: sh73a0: div4 clocks must check the kick bit before changing rate
Message-Id: <20130525005843.GD4476@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.00.1305230008400.20133@axis700.grange>
In-Reply-To: <alpine.DEB.2.00.1305230008400.20133@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 23, 2013 at 12:10:00AM +0200, Guennadi Liakhovetski wrote:
> According to the datasheet, it is not allowed to change div4 clock rates
> if an earlier rate change operation is still in progress, as indicated by
> a set kick bit.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/clock-sh73a0.c |   24 +++++++++++++++++++-----
>  1 files changed, 19 insertions(+), 5 deletions(-)

Thanks Guennadi,

I will queue this up in the soc-sh73a0 branch for v3.11.
