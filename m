From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 30 Sep 2010 01:12:28 +0000
Subject: Re: [PATCH] sh: fix a kfree address in clkdev code
Message-Id: <20100930011228.GC18073@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1009171124350.4988@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1009171124350.4988@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 17, 2010 at 11:25:10AM +0200, Guennadi Liakhovetski wrote:
> kfree() in clkdev_drop() function should actually be called with an address of
> a struct clk_lookup_alloc object, and not struct clk_lookup, as presently done.
> This just happens to work, because "struct clk_lookup cl" is the first
> member in struct clk_lookup_alloc.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.
