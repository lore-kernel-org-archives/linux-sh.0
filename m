From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 28 Jun 2012 14:17:51 +0000
Subject: Re: [PATCH 01/13 v3] sh: ecovec: switch MMC power control to regulators
Message-Id: <20120628141751.GC28162@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1206281223500.31813@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1206281223500.31813@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 28, 2012 at 12:29:46PM +0200, Guennadi Liakhovetski wrote:
> Power on the CN11 and CN12 SD/MMC slots on ecovec is controlled by GPIOs,
> which makes it possible to use the fixed voltage regulator driver to switch
> card power on and off.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied now, though you still didn't make the dev_name() changes for
gpio_request().
