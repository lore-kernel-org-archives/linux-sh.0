From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 11 Feb 2010 17:04:02 +0000
Subject: Re: [PATCH 3/5 v2] sh: separate DMA headers, used by the legacy
Message-Id: <20100211170402.GA32273@opensource.wolfsonmicro.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1002111726340.4484@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1002111726340.4484@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 11, 2010 at 05:50:14PM +0100, Guennadi Liakhovetski wrote:

> Separate SH DMA headers into ones, commonly used by both drivers, and ones,
> specific to each of them. This will make the future development of the
> dmaengine driver easier.

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but note that this will only be appliable after the SIU driver has
merged down into mainline.
