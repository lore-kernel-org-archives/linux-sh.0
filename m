From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Mon, 19 Feb 2018 16:22:48 +0000
Subject: Re: [PATCH 0/8] SH7786 PCIe support fixes
Message-Id: <20180219172248.12360360@windsurf.lan>
List-Id: <linux-sh.vger.kernel.org>
References: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
In-Reply-To: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

Hello,

On Mon,  4 Dec 2017 16:08:59 +0100, Thomas Petazzoni wrote:

> Thomas Petazzoni (8):
>   arch/sh: add sh7786_mm_sel() function
>   arch/sh: make the DMA mapping operations observe dev->dma_pfn_offset
>   arch/sh: pci: don't use disabled resources
>   arch/sh: pcie-sh7786: mark unavailable PCI resource as disabled
>   arch/sh: pcie-sh7786: exclude unusable PCI MEM areas
>   arch/sh: pcie-sh7786: adjust PCI MEM and IO regions
>   arch/sh: pcie-sh7786: adjust the memory mapping
>   arch/sh: pcie-sh7786: handle non-zero DMA offset

It's been more than 2 months, and I haven't received any review on this
patch series.

It is very likely that I am one of the only active user of a SH7786
platform, so I don't think those patches will break things for anybody.
Would it be possible to just merge them ? I doubt anyone will be
interested in doing a very careful and detailed review, since I doubt
anyone is interested in this SH7786 platform anymore.

The only patch that can potentially break things for other is "arch/sh:
make the DMA mapping operations observe dev->dma_pfn_offset" but I
believe it is useful to have it and fix any fallout (which should be
trivial).

So please, please, merge :-)

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
