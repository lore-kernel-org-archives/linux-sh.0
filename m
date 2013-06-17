From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 17 Jun 2013 07:58:57 +0000
Subject: Re: [PATCH v4] irqchip: renesas-intc-irqpin: DT binding for sense bitfield width
Message-Id: <201306170958.57844.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1306131121230.31976@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1306131121230.31976@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 13 June 2013, Guennadi Liakhovetski wrote:
> Most Renesas irqpin controllers have 4-bit sense fields, however, some
> have different widths. This patch adds a DT binding to optionally
> specify such non-standard values.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
