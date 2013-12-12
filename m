From: Jason Cooper <jason@lakedaemon.net>
Date: Thu, 12 Dec 2013 12:38:59 +0000
Subject: Re: [PATCH] MAINTAINERS: Add DesignWare, i.MX6, Armada, R-Car PCI host maintainers
Message-Id: <20131212123859.GH10053@titan.lakedaemon.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20131211183237.GI4699@google.com>
 <52A96877.90902@free-electrons.com>
 <001901cef71a$41f3a520$c5daef60$%han@samsung.com>
In-Reply-To: <001901cef71a$41f3a520$c5daef60$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Dec 12, 2013 at 06:12:18PM +0900, Jingoo Han wrote:
> On Thursday, December 12, 2013 4:41 PM, Gregory CLEMENT wrote:
> > On 11/12/2013 19:32, Bjorn Helgaas wrote:
> > > If this looks reasonable, I'll merge it via the PCI tree for v3.13.
> > >
> > > Bjorn
> 
> [.....]
> 
> > > +PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
> > > +M:	Jason Cooper <jason@lakedaemon.net>
> > > +L:	linux-pci@vger.kernel.org
> > > +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > > +S:	Maintained
> > > +F:	drivers/pci/host/*mvebu*
> > 
> > I think that Thomas Petazzoni would be more appropriate, he worked
> > on the mvebu PCIe since 6 moths and now know very well the
> > subject. Until now all the mvebu PCIe related questions were
> > managed by Thomas.
> 
> I think so, too. :-)
> 
> Thomas Petazzoni is the author of the  mvebu PCIe. Also, he did
> The basic foundation of PCIe Host with Thierry Reding.  I think
> That he is the best person for the Maintainer of the mvebu PCIe.

100% Ack.  Thanks for the nomination, but Thomas is the person best
suited to review patches and maintain the driver.  If you want some
patch wrangling, I don't mind helping out, but I'd prefer Thomas be the
maintainer here.

thx,

Jason.
