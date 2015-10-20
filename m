From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 20 Oct 2015 10:28:17 +0000
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Drop LPAE Kconfig dependency
Message-Id: <1853633.usacnlzPRA@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20151019030253.6274.46547.sendpatchset@little-apple> <1739171.POGWkgX12k@avalon> <CANqRtoTuK4gcc7WMTcMQ4REtRL8oGtT_hLpo7UHgPiQ8e6L+9A@mail.gmail.com>
In-Reply-To: <CANqRtoTuK4gcc7WMTcMQ4REtRL8oGtT_hLpo7UHgPiQ8e6L+9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: iommu@lists.linux-foundation.org, SH-Linux <linux-sh@vger.kernel.org>, joro <joro@8bytes.org>, linux-kernel <linux-kernel@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>

Hi Magnus,

On Tuesday 20 October 2015 17:54:59 Magnus Damm wrote:
> On Mon, Oct 19, 2015 at 3:42 PM, Laurent Pinchart wrote:
> > On Monday 19 October 2015 12:02:53 Magnus Damm wrote:
> >> From: Magnus Damm <damm+renesas@opensource.se>
> >> 
> >> Neither the ARM page table code enabled by IOMMU_IO_PGTABLE_LPAE
> >> nor the IPMMU_VMSA driver actually depends on ARM_LPAE, so get
> >> rid of the dependency.
> >> 
> >> Tested with ipmmu-vmsa on r8a7794 ALT and a kernel config using:
> >>  # CONFIG_ARM_LPAE is not set
> > 
> > The driver only supports the 40-bits page table format for now, hence the
> > dependency on LPAE, but it indeed seems that the dependency is bogus. As
> > long as the 8 MSBs of the translated address are all 0 I assume the
> > output 40-bit address is usable on a 32-bit physical address system.
> > 
> > How have you tested the patch ?
> 
> Modetest with local IPMMUMX enablement on r8a7794 ALT.

Then,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

