From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 18 Apr 2011 09:40:55 +0000
Subject: Re: [PATCH] sh: cosmetic improvement: use an existing pointer
Message-Id: <20110418094054.GH32457@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104152004360.18593@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1104152004360.18593@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Apr 16, 2011 at 06:34:14PM +0800, Simon Horman wrote:
> On Fri, Apr 15, 2011 at 08:05:27PM +0200, Guennadi Liakhovetski wrote:
> > Use an existing local variable, instead of calculating the pointer
> > multiple times explicitly.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <damm@opensource.se>
> 
> This looks correct to me.
> 
> Reviewed-by: Simon Horman <horms@verge.net.au>

I'll skip this for now given that there are quite a few people presently
hacking on this file and it's not worth generating conflicts over.

Feel free to resubmit on top of the unified framework once the dust
settles, though.
