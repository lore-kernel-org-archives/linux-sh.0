From: Christoph Hellwig <hch@lst.de>
Date: Wed, 16 Sep 2020 06:13:59 +0000
Subject: Re: [PATCH 6/6] dma-mapping: introduce DMA range map, supplanting dma_pfn_offset
Message-Id: <20200916061359.GA8424@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200914073343.1579578-1-hch@lst.de> <20200914073343.1579578-7-hch@lst.de> <20200914230147.GA3251212@xps15> <20200915054122.GA18079@lst.de> <20200915195501.GA3666944@xps15>
In-Reply-To: <20200915195501.GA3666944@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jim Quinlan <james.quinlan@broadcom.com>, Nathan Chancellor <natechancellor@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-remoteproc@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, arnaud.pouliquen@st.com, loic.pallardy.st.com@lst.de

On Tue, Sep 15, 2020 at 01:55:01PM -0600, Mathieu Poirier wrote:
> That did the trick - the stm32 platform driver's probe() function completes and
> the remote processor is operatinal. 
> 
> That being said the value returned by function dma_to_pfn()
> is 0x137fff in the original code and 0xfffff with your patches applied.

Yes, that is intentional.  The old code just applied the range and got
an out of range offset, the new one reports the max offset.
