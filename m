From: Bjorn Helgaas <helgaas@kernel.org>
Date: Mon, 08 Jan 2018 22:12:58 +0000
Subject: Re: [PATCH 0/8] SH7786 PCIe support fixes
Message-Id: <20180108221258.GA31640@bhelgaas-glaptop.roam.corp.google.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
 <20180107160627.5a1231fa@windsurf>
In-Reply-To: <20180107160627.5a1231fa@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

On Sun, Jan 07, 2018 at 04:06:27PM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> On Mon,  4 Dec 2017 16:08:59 +0100, Thomas Petazzoni wrote:
> 
> > Thomas Petazzoni (8):
> >   arch/sh: add sh7786_mm_sel() function
> >   arch/sh: make the DMA mapping operations observe dev->dma_pfn_offset
> >   arch/sh: pci: don't use disabled resources
> >   arch/sh: pcie-sh7786: mark unavailable PCI resource as disabled
> >   arch/sh: pcie-sh7786: exclude unusable PCI MEM areas
> >   arch/sh: pcie-sh7786: adjust PCI MEM and IO regions
> >   arch/sh: pcie-sh7786: adjust the memory mapping
> >   arch/sh: pcie-sh7786: handle non-zero DMA offset
> 
> It's been a month. Any feedback on those patches ?

I'm assuming Yoshinori and Rich will handle these.  Let me know if
otherwise.
