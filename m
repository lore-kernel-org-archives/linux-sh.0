From: Christoph Hellwig <hch@lst.de>
Date: Thu, 27 Aug 2020 06:35:17 +0000
Subject: Re: [PATCH v11 00/11] PCI: brcmstb: enable PCIe for STB chips
Message-Id: <20200827063517.GA4637@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <b19bc982-a0c4-c6ff-d8f5-650f2b3a83c8@gmail.com>
In-Reply-To: <b19bc982-a0c4-c6ff-d8f5-650f2b3a83c8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "open list:SUPERH" <linux-sh@vger.kernel.org>, linux-pci@vger.kernel.org, "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" <linux-remoteproc@vger.kernel.org>, "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>, Julien Grall <julien.grall@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Saravana Kannan <saravanak@google.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, Alan Stern <stern@rowland.harvard.edu>, "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, Dan Williams <dan.j.williams@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

On Tue, Aug 25, 2020 at 10:40:27AM -0700, Florian Fainelli wrote:
> Hi,
>
> On 8/24/2020 12:30 PM, Jim Quinlan wrote:
>>
>> Patchset Summary:
>>    Enhance a PCIe host controller driver.  Because of its unusual design
>>    we are foced to change dev->dma_pfn_offset into a more general role
>>    allowing multiple offsets.  See the 'v1' notes below for more info.
>
> We are version 11 and counting, and it is not clear to me whether there is 
> any chance of getting these patches reviewed and hopefully merged for the 
> 5.10 merge window.
>
> There are a lot of different files being touched, so what would be the 
> ideal way of routing those changes towards inclusion?

FYI, I offered to take the dma-mapping bits through the dma-mapping tree.
I have a bit of a backlog, but plan to review and if Jim is ok with that
apply the current version.
