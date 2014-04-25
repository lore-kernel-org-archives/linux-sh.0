From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 25 Apr 2014 20:05:50 +0000
Subject: Re: [PATCH] pci-rcar-gen2: add device tree support
Message-Id: <23319337.TNDCodMgFf@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <201404080141.21605.sergei.shtylyov@cogentembedded.com>
 <20140425174535.GF32246@google.com>
In-Reply-To: <20140425174535.GF32246@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday 25 April 2014 11:45:35 Bjorn Helgaas wrote:
> > +This is the bridge used internally to connect the USB controllers to the
> > +AHB. There is one bridge instance per USB port connected to the internal
> > +OHCI and EHCI controllers.
> > +
> > +Required properties:
> > +- compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
> > +           "renesas,pci-r8a7791" for the R8A7791 SoC.
> > +- reg:       A list of physical regions to access the device: the first is
> > +     the operational registers for the OHCI/EHCI controllers and the
> > +     second is for the bridge configuration and control registers.
> > +- interrupts: interrupt for the device.
> > +- clocks: The reference to the device clock.
> > +- bus-range: The PCI bus number range; as this is a single bus, the range
> > +           should be specified as the same value twice.

Actually, this doesn't conform to the generic PCI binding, which requires
a number of additional properties.

	Arnd
