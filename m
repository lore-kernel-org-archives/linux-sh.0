From: Christoph Hellwig <hch@lst.de>
Date: Tue, 08 Sep 2020 12:20:45 +0000
Subject: Re: [PATCH v11 00/11] PCI: brcmstb: enable PCIe for STB chips
Message-Id: <20200908122045.GA31727@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <b19bc982-a0c4-c6ff-d8f5-650f2b3a83c8@gmail.com>
 <20200827063517.GA4637@lst.de>
 <CA+-6iNy3U9pO0Bykzgvb9n9fcsBi6FiatLdpA1s0HgQNWZ49mg@mail.gmail.com>
 <20200907091649.GA6428@e121166-lin.cambridge.arm.com>
 <CA+-6iNzoz3pM2pJksXogeuou6wB9W-59rN-amCLERFLuY5zLMg@mail.gmail.com>
 <00e49acb-c659-de10-3e87-76bfd82e4a76@gmail.com>
 <20200908104226.GB22909@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200908104226.GB22909@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "open list:SUPERH" <linux-sh@vger.kernel.org>, "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" <linux-remoteproc@vger.kernel.org>, "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>, Julien Grall <julien.grall@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Saravana Kannan <saravanak@google.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>, "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, Alan Stern <stern@rowland.harvard.edu>, "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, Stefano Stabellini <sstabellini@kernel.org>, "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, Dan Williams <dan.j.williams@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

On Tue, Sep 08, 2020 at 11:42:26AM +0100, Lorenzo Pieralisi wrote:
> > Maybe we can parallelize the PCIe driver review while the DMA changes
> > are being worked on in Christoph's branch. Lorenzo, are you fine with
> > the PCIe changes proper?
> 
> I will have a look - the main contentious point was about the DMA
> changes - if Christoph is happy with them I am OK with them
> too - I hope there is not anything controversial in the host
> bridge driver itself but I will look into it.

I'm pretty happy with the overall shape.  Now we just need to squeeze
out the regressions..
