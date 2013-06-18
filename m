From: Simon Horman <horms@verge.net.au>
Date: Tue, 18 Jun 2013 07:16:15 +0000
Subject: Re: [PATCH v4] irqchip: renesas-intc-irqpin: DT binding for sense bitfield width
Message-Id: <20130618071615.GC24960@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1306131121230.31976@axis700.grange>
 <201306170958.57844.arnd@arndb.de>
In-Reply-To: <201306170958.57844.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 17, 2013 at 09:58:57AM +0200, Arnd Bergmann wrote:
> On Thursday 13 June 2013, Guennadi Liakhovetski wrote:
> > Most Renesas irqpin controllers have 4-bit sense fields, however, some
> > have different widths. This patch adds a DT binding to optionally
> > specify such non-standard values.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks, I have queued this up in the dt branch.
