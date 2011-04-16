From: Simon Horman <horms@verge.net.au>
Date: Sat, 16 Apr 2011 10:34:14 +0000
Subject: Re: [PATCH] sh: cosmetic improvement: use an existing pointer
Message-Id: <20110416103414.GG16353@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104152004360.18593@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1104152004360.18593@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 15, 2011 at 08:05:27PM +0200, Guennadi Liakhovetski wrote:
> Use an existing local variable, instead of calculating the pointer
> multiple times explicitly.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <damm@opensource.se>

This looks correct to me.

Reviewed-by: Simon Horman <horms@verge.net.au>
