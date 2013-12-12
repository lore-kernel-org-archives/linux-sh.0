From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Dec 2013 09:12:18 +0000
Subject: Re: [PATCH] MAINTAINERS: Add DesignWare, i.MX6, Armada, R-Car PCI host maintainers
Message-Id: <001901cef71a$41f3a520$c5daef60$%han@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131211183237.GI4699@google.com>
 <52A96877.90902@free-electrons.com>
In-Reply-To: <52A96877.90902@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday, December 12, 2013 4:41 PM, Gregory CLEMENT wrote:
> On 11/12/2013 19:32, Bjorn Helgaas wrote:
> > If this looks reasonable, I'll merge it via the PCI tree for v3.13.
> >
> > Bjorn

[.....]

> > +PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
> > +M:	Jason Cooper <jason@lakedaemon.net>
> > +L:	linux-pci@vger.kernel.org
> > +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +S:	Maintained
> > +F:	drivers/pci/host/*mvebu*
> 
> I think that Thomas Petazzoni would be more appropriate, he worked
> on the mvebu PCIe since 6 moths and now know very well the
> subject. Until now all the mvebu PCIe related questions were
> managed by Thomas.

I think so, too. :-)

Thomas Petazzoni is the author of the  mvebu PCIe. Also, he did
The basic foundation of PCIe Host with Thierry Reding.  I think
That he is the best person for the Maintainer of the mvebu PCIe.

Best regards,
Jingoo Han

