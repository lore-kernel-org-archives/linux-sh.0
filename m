From: Simon Horman <horms@verge.net.au>
Date: Tue, 10 Nov 2015 01:15:53 +0000
Subject: Re: [PATCH] PCI: rcar (usb): DT can override default window settings
Message-Id: <20151110011553.GH1040@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1446567566-10952-1-git-send-email-phil.edworthy@renesas.com>
 <20151105134947.GA26919@rob-hp-laptop>
In-Reply-To: <20151105134947.GA26919@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: Phil Edworthy <phil.edworthy@renesas.com>, Bjorn Helgaas <bhelgaas@google.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, Nov 05, 2015 at 07:49:47AM -0600, Rob Herring wrote:
> On Tue, Nov 03, 2015 at 04:19:26PM +0000, Phil Edworthy wrote:
> > If the dtb specifies dma-ranges, we use those values. Otherwise, we
> > default to the values that were previously hardcoded into the driver.
> > 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> >  .../devicetree/bindings/pci/pci-rcar-gen2.txt      |  6 ++
> 
> Acked-by: Rob Herring <robh@kernel.org>

Bjorn,

this looks good to me. Please feel free to apply.

Acked-by: Simon Horman <horms+renesas@verge.net.au>
