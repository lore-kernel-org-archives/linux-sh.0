From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Wed, 06 Jul 2016 16:19:18 +0000
Subject: Re: [PATCH v6 12/22] sh: Add PCI host bridge driver for SH7751
Message-Id: <87y45eloxl.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
	<1467564402-2649-13-git-send-email-ysato@users.sourceforge.jp>
	<20160705155306.GA7857@rob-hp-laptop>
In-Reply-To: <20160705155306.GA7857@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 06 Jul 2016 00:53:06 +0900,
Rob Herring wrote:
> 
> On Mon, Jul 04, 2016 at 01:46:32AM +0900, Yoshinori Sato wrote:
> > This is an alternative SH7751 PCI driver.
> > Existing driver (arch/sh/drivers/pci/pci-sh7751) uses SH specific interface.
> > But this driver uses common PCI interface. It is more modern and generic.
> > 
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > ---
> >  .../devicetree/bindings/pci/sh7751-pci.txt         |  37 +++
> 
> Please add acks when posting new versions.
> 
> >  arch/sh/boards/Kconfig                             |   1 +
> >  arch/sh/drivers/Makefile                           |   2 +
> >  drivers/pci/host/Kconfig                           |   7 +
> >  drivers/pci/host/Makefile                          |   1 +
> >  drivers/pci/host/pci-sh7751.c                      | 327 +++++++++++++++++++++
> >  6 files changed, 375 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/sh7751-pci.txt
> >  create mode 100644 drivers/pci/host/pci-sh7751.c

Oh. Sorry.
I forgot it.

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
