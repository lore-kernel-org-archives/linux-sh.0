From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 14 Feb 2008 05:23:24 +0000
Subject: Re: [PATCH] sh: use ctrl_in/out for on chip pci access
Message-Id: <20080214052324.GB12436@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080214045243.6842.31222.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080214045243.6842.31222.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 14, 2008 at 01:52:43PM +0900, Magnus Damm wrote:
> This patch makes sure ctrl_inN/outN are used instead of inN/outN for on chip
> pci registers. Without this patch addresses may be adjusted using the value
> in generic_io_base. This patch makes it possible to set generic_io_base and
> have pci without reading and writing all over the place.

On Thu, Feb 14, 2008 at 01:59:02PM +0900, Magnus Damm wrote:
> This patch is a fix to make sure readsN/writesN are used over insN/outsN for
> ioreadN_rep/iowriteN_rep.
> 
> The current state of the sh io code is that mmio operations like readN/writeN
> and ioreadN/iowriteN are unaffected by the value of generic_io_base. This is
> different fom port based io like inN/outN which gets adjusted using the value
> in generic_io_base.
> 
> Without this patch ioreadN_rep/iowriteN_rep get their addresses adjusted.
> The address for mmio access is adjusted using generic_io_base. This is wrong.
> The ata core code currently crashes if generic_io_base is set.
> 
> This patch changes ioreadN_rep/iowriteN_rep to follow the same rules as the
> rest of the mmio operations, ie don't adjust using generic_io_base.

On Thu, Feb 14, 2008 at 02:05:57PM +0900, Magnus Damm wrote:
> Use generic_io_base to point out the pci io window, and make sure the
> highest port address used is SH7751_PCI_IO_SIZE - 1.
> 
> This patch fixes pci io port access for the r2d boards - CONFIG_8139TOO_PIO
> now works as expected. So does the alsa driver for CMI8738.

Applied, thanks.
