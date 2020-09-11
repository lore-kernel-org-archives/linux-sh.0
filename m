From: santosh.shilimkar@oracle.com
Date: Fri, 11 Sep 2020 18:00:52 +0000
Subject: Re: [PATCH 2/3] ARM/keystone: move the DMA offset handling under ifdef CONFIG_ARM_LPAE
Message-Id: <f13c72b9-9efa-7b9d-6c23-19f87b151bc4@oracle.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200910054038.324517-1-hch@lst.de>
 <20200910054038.324517-3-hch@lst.de>
 <20200911111551.GG1551@shell.armlinux.org.uk>
In-Reply-To: <20200911111551.GG1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>, Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Santosh Shilimkar <ssantosh@kernel.org>, Jim Quinlan <james.quinlan@broadcom.com>, Nathan Chancellor <natechancellor@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org

On 9/11/20 4:15 AM, Russell King - ARM Linux admin wrote:
> On Thu, Sep 10, 2020 at 07:40:37AM +0200, Christoph Hellwig wrote:
>> The DMA offset notifier can only be used if PHYS_OFFSET is at least
>> KEYSTONE_HIGH_PHYS_START, which can't be represented by a 32-bit
>> phys_addr_t.  Currently the code compiles fine despite that, a pending
>> change to the DMA offset handling would create a compiler warning for
>> this case.  Add an ifdef to not compile the code except for LPAE
>> configs.
> 
> However, to have use of the high physical offset, LPAE needs to be
> enabled, which ensures that phys_addr_t is 64-bit.
> 
> I believe that DMA is non-coherent on this platform unless the high
> physical address is used. Or something like that.
> 
Exactly. Higher address ranges needs to be used for DMA coherency.

Regards,
Santosh
