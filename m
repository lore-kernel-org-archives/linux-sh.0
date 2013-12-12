From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Dec 2013 10:47:02 +0000
Subject: Re: [PATCH] MAINTAINERS: Add DesignWare, i.MX6, Armada, R-Car PCI host maintainers
Message-Id: <000001cef727$7da93730$78fba590$%han@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131211183237.GI4699@google.com>
 <20131212070045.GO18380@S2101-09.ap.freescale.net>
In-Reply-To: <20131212070045.GO18380@S2101-09.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday, December 12, 2013 4:01 PM, Shawn Guo wrote:
> On Wed, Dec 11, 2013 at 11:32:37AM -0700, Bjorn Helgaas wrote:
> > +PCI DRIVER FOR IMX6
> > +M:	Shawn Guo <shawn.guo@linaro.org>
> 
> Thanks for the nomination.  But I think a better person for this
> position would be Richard Zhu <r65037@freescale.com> (copied).  He knows
> the driver and controller much better than myself, and most importantly
> he is the driver owner for Freescale kernel and he has the contact to
> Freescale PCIe hardware people.

I agree with Shawn Guo's opinion. :-)

Richard Zhu has been maintaining i.MX6 PCIe driver. Also he can contact
Freescale PCIe hardware engineers. Thus, he is the appropriate person
for the Maintainer of i.MX PCIe.

Best regards,
Jingoo Han

> 
> Shawn
> 
> > +L:	linux-pci@vger.kernel.org
> > +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +S:	Maintained
> > +F:	drivers/pci/host/*imx6*

