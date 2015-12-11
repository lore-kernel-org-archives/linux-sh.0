From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Dec 2015 02:14:34 +0000
Subject: Re: [PATCH v2 0/4] PCI: rcar, rcar-gen2: More Gen2 compatibility strings
Message-Id: <20151211021434.GH9927@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449096700-23304-1-git-send-email-horms+renesas@verge.net.au>
 <20151209183743.GH31930@localhost>
In-Reply-To: <20151209183743.GH31930@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Dec 09, 2015 at 12:37:43PM -0600, Bjorn Helgaas wrote:
> On Thu, Dec 03, 2015 at 07:51:36AM +0900, Simon Horman wrote:
> > Hi,
> > 
> > this short series adds generic gen2 and SoC-specific r8a7793 compatibility
> > strings to the rcar PCI and rcar-gen2 PCIE drivers. The intention is to
> > provide a complete set of compatibility strings for known Gen2 SoCs.
> > 
> > Key Changes in v2:
> > * Include "rcar-" in generic bindings
> > 
> > Simon Horman (4):
> >   PCI: rcar-gen2: add gen2 fallback compatibility string
> >   PCI: rcar-gen2: add device tree support for r8a7793
> >   PCI: rcar: add gen2 fallback compatibility string
> >   PCI: rcar: add device tree support for r8a7793
> > 
> >  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 12 ++++++++++--
> >  Documentation/devicetree/bindings/pci/rcar-pci.txt      | 14 +++++++++++---
> >  drivers/pci/host/pci-rcar-gen2.c                        |  1 +
> >  drivers/pci/host/pcie-rcar.c                            |  1 +
> >  4 files changed, 23 insertions(+), 5 deletions(-)
> 
> I applied these:
> 
> >   PCI: rcar-gen2: add gen2 fallback compatibility string
> >   PCI: rcar: add gen2 fallback compatibility string
> 
> to pci/host-rcar for v4.5, thanks!
> 
> I haven't applied the R8A7793 binding documentation updates yet, but
> I'll be happy to do so given a short description of why they're
> useful (since they don't update a DT or the driver).  Or they could be
> merged via a DT tree.

To clarify: you would like a description in the changelog?
