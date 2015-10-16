From: Bjorn Helgaas <helgaas@kernel.org>
Date: Fri, 16 Oct 2015 21:34:43 +0000
Subject: Re: [PATCH 0/4] PCI: rcar: Add support for ARM64 and multiple instances
Message-Id: <20151016213443.GD21346@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Simon Horman <horms@verge.net.au>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 02, 2015 at 11:25:03AM +0100, Phil Edworthy wrote:
> Fixes and changes to get PCIe working on ARM64 with mulitple instances.
> 
> I've tested these on ARM (Koelsch board), and it works fine.
> I've also tested on ARM64 (Salvator-X board), but I currently have an issue
> with inbound PCI accesses. I am reasonably sure that this problem is hardware
> related.
> 
> Phil Edworthy (4):
>   PCI: rcar-pcie: Make PCI aware of the IO resources
>   PCI: rcar-pcie: Remove dependency on ARM-specific struct hw_pci
>   PCI: rcar-pcie: Set root bus nr to that provided in DT
>   PCI: rcar-pcie: Fix IO offset for multiple instances

This all looks pretty reasonable to me, but I'm waiting for an ack from
Simon before merging it.

Bjorn
