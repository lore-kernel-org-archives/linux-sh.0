From: Joerg Roedel <joro@8bytes.org>
Date: Fri, 23 Oct 2015 09:49:48 +0000
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Drop LPAE Kconfig dependency
Message-Id: <20151023094947.GA17032@8bytes.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20151019030253.6274.46547.sendpatchset@little-apple>
In-Reply-To: <20151019030253.6274.46547.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au

On Mon, Oct 19, 2015 at 12:02:53PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Neither the ARM page table code enabled by IOMMU_IO_PGTABLE_LPAE
> nor the IPMMU_VMSA driver actually depends on ARM_LPAE, so get
> rid of the dependency.
> 
> Tested with ipmmu-vmsa on r8a7794 ALT and a kernel config using:
>  # CONFIG_ARM_LPAE is not set
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Applied, thanks.

