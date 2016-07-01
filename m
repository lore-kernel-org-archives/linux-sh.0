From: Rob Herring <robh@kernel.org>
Date: Fri, 01 Jul 2016 01:43:30 +0000
Subject: Re: [PATCH v4 12/22] sh: Add PCI host bridge driver for SH7751
Message-Id: <20160701014330.GA27839@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
 <1467207667-15768-13-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467207667-15768-13-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 29, 2016 at 10:40:57PM +0900, Yoshinori Sato wrote:
> This is an alternative SH7751 PCI driver.
> Existing driver (arch/sh/drivers/pci/pci-sh7751) uses SH specific interface.
> But this driver uses common PCI interface. It is more modern and generic.
> 
> Changes v4
> Add reg description.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../devicetree/bindings/pci/sh7751-pci.txt         |  37 +++

Acked-by: Rob Herring <robh@kernel.org>

>  arch/sh/boards/Kconfig                             |   1 +
>  arch/sh/drivers/Makefile                           |   2 +
>  arch/sh/include/asm/io.h                           |   6 +
>  drivers/pci/host/Kconfig                           |   7 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pci-sh7751.c                      | 326 +++++++++++++++++++++
>  7 files changed, 380 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sh7751-pci.txt
>  create mode 100644 drivers/pci/host/pci-sh7751.c
