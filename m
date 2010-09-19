From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sun, 19 Sep 2010 15:05:45 +0000
Subject: Re: [PATCH 4/5] ASoC: fix clkdev API usage in sh/migor.c
Message-Id: <20100919150545.GD18789@opensource.wolfsonmicro.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
 <Pine.LNX.4.64.1009171215120.4988@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1009171215120.4988@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>

On Fri, Sep 17, 2010 at 12:30:11PM +0200, Guennadi Liakhovetski wrote:
> The clkdev API doesn't use .name and .id members of struct clk for clock
> lookup. Instead clocks should be added to a lookup list. Without this patch
> audio om the Migo-R board fails silently.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

> As mentioned before - please also apply to 2.6.36.

Applied and merge up to -next.  As I said, please submit patches against
the kernel version they should be applied to and please submit separate
serieses for separate verisons.
