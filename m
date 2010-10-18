From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 18 Oct 2010 11:34:11 +0000
Subject: Re: [PATCH] sh: fix clk_get() error handling
Message-Id: <20101018113410.GE5809@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1010151637031.3945@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1010151637031.3945@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 15, 2010 at 04:37:24PM +0200, Guennadi Liakhovetski wrote:
> clk_get() returns an ERR_PTR(errno) on error and not NULL.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.
