From: Marek Vasut <marex@denx.de>
Date: Thu, 06 Mar 2014 15:33:31 +0000
Subject: Re: [PATCH v2 6/6] PCI: designware: use new OF interrupt mapping when possible
Message-Id: <201403061633.31260.marex@denx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-7-git-send-email-l.stach@pengutronix.de>
 <000201cf38e6$5b02d6e0$110884a0$%han@samsung.com>
In-Reply-To: <000201cf38e6$5b02d6e0$110884a0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday, March 06, 2014 at 03:47:03 AM, Jingoo Han wrote:
> On Wednesday, March 05, 2014 10:26 PM, Lucas Stach wrote:
> > This is the recommended method of doing the IRQ
> > mapping. For old devicetrees we fall back to the
> > previous practice.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> (+cc Mohit KUMAR, Richard Zhu, Pratyush Anand, Marek Vasut,
>        Kishon Vijay Abraham I)
> 
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> 
> It works properly on Exynos platform.
> Thank you.

Looks reasonable,

Reviewed-by: Marek Vasut <marex@denx.de>

+CC Troy if he wants to test it on SL/N6X .

Best regards,
Marek Vasut
