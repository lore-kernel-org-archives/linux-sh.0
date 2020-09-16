From: Christoph Hellwig <hch@lst.de>
Date: Wed, 16 Sep 2020 06:14:53 +0000
Subject: support range based offsets in dma-direct v3
Message-Id: <20200916061500.1970090-1-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200910054038.324517-1-hch@lst.de>
In-Reply-To: <20200910054038.324517-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jim Quinlan <james.quinlan@broadcom.com>, Nathan Chancellor <natechancellor@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-remoteproc@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org

Hi all,

this series adds range-based offsets to the dma-direct implementation.  The
guts of the change are a patch from Jim with some modifications from me,
but to do it nicely we need to ARM patches to prepare for it as well.

Changes since v2:
 - fix a mismerge
 - return (phys_addr_t)-1 from translate_dma_to_phys when there is no
   matching range to fix dma_capable checks

Changes since v1:
 - rebased on top of the latests dma-mapping for-next tree
 - add two more trivial ARM cleanups
 - remove the DMA property inheritance hack in usb
 - move the remaining copy of the ranges into the remoteproc driver
   as it should not be seen as a general API, but as a quirk for
   remoteproc that we need to fix ASAP

Diffstat:
