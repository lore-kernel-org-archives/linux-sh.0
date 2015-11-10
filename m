From: Simon Horman <horms@verge.net.au>
Date: Tue, 10 Nov 2015 01:21:20 +0000
Subject: Re: [PATCH] PCI: pcie-rcar: Fix OF node passed to MSI irq domain
Message-Id: <20151110012120.GI1040@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1446542899-25137-1-git-send-email-phil.edworthy@renesas.com>
 <20151107135951.GD21726@katana>
In-Reply-To: <20151107135951.GD21726@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Phil Edworthy <phil.edworthy@renesas.com>, Bjorn Helgaas <bhelgaas@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Nov 07, 2015 at 02:59:51PM +0100, Wolfram Sang wrote:
> On Tue, Nov 03, 2015 at 09:28:19AM +0000, Phil Edworthy wrote:
> > The OF node passed to irq_domain_add_linear() should be a
> > pointer to interrupt controller's device tree node, or NULL,
> > but not the PCI controller's node.
> > 
> > This fixes an oops in msi_domain_alloc_irqs() when it tries
> > to call msi_check().
> > 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Hi Bjorn,

please feel free to apply.

Acked-by: Simon Horman <horms+renesas@verge.net.au>


