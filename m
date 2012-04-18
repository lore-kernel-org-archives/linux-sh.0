From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 18 Apr 2012 12:01:07 +0000
Subject: Re: [PATCH 2/6] mmc: sh_mmcif: do not manage PM clocks manually
Message-Id: <20120418120106.GA22189@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1204181323290.30514@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1204181323290.30514@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 18, 2012 at 01:28:32PM +0200, Guennadi Liakhovetski wrote:
> On sh-mobile platforms the MMC clock frequency for the MMCIF unit is
> obtained from the same clock, as the one, that runtime power-manages the
> controller. The MMCIF driver has to access that clock directly,
> bypassing the runtime PM framework, to get its frequency, but it
> shouldn't enable or disable it.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

I don't understand your logic. clk_get_rate() requires the clock to be
enabled, the result is undefined otherwise. If you have a case where the
clock is already enabled and you can read the rate directly that's fine,
but it's still an API violation without enable/disable pairs.
