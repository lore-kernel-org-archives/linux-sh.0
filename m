From: Stephen Warren <swarren@wwwdotorg.org>
Date: Thu, 06 Mar 2014 17:36:50 +0000
Subject: Re: [PATCH v2 2/6] PCI: tegra: use new OF interrupt mapping when possible
Message-Id: <5318B232.2020507@wwwdotorg.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-3-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1394025951-32438-3-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 03/05/2014 06:25 AM, Lucas Stach wrote:
> This is the recommended method of doing the IRQ
> mapping. For old devicetrees we fall back to the
> previous practice.

Tested-by: Stephen Warren <swarren@nvidia.com>

I tested both with and without patch 1/6, and the PCIe-based NIC on
Beaver worked fine either way. Without patch 1/6, I do see:

pci 0000:00:01.0: of_irq_parse_pci() failed with rc=-22

... but that seems reasonable given that the DT that of_irq_parse_pci()
parses is missing, and did correctly trigger the fallback path, so
everything still worked.
