From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 28 Feb 2014 20:04:14 +0000
Subject: Re: [PATCH 0/7] PCI irq mapping fixes and cleanups
Message-Id: <201402282104.14295.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday 28 February 2014, Lucas Stach wrote:
> This series cleans up the PCI irq mapping for all
> the ARM PCI host drivers, so they handle it in the
> way defined in the common PCI bindings.
> 
> Testing appreciated.
> 
> Lucas Stach (7):
>   ARM: dts: tegra: add PCIe interrupt mapping properties
>   PCI: tegra: use new OF interrupt mapping when possible
>   PCI: rcar: use new OF interrupt mapping when possible
>   ARM: dts: exynos5440: fix PCIe interrupt mapping
>   ARM: dts: imx6: add PCIe interrupt mapping properties
>   PCI: designware: use new OF interrupt mapping when possible
>   PCI: designware: split samsung and fsl bindings

Patches 1-6

Acked-by: Arnd Bergmann <arnd@arndb.de>

For the last patch, the clock information looks like it needs to
be fixed. I realize that you are just documenting what the driver
is using at the moment, but that is not a proper way of establishing
a binding.

	Arnd
