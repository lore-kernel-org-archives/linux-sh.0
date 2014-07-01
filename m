From: Simon Horman <horms@verge.net.au>
Date: Tue, 01 Jul 2014 02:27:46 +0000
Subject: Re: [PATCH v2 0/3] PCI: host: pcie-rcar: minor clean ups
Message-Id: <20140701022746.GA13917@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404114864-17330-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1404114864-17330-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

On Mon, Jun 30, 2014 at 08:54:21AM +0100, Phil Edworthy wrote:
> Relatively minor clean up patches for the pcie-rcar driver. These
> are on top of Sergei's recent patch "pcie-rcar: kill duplicate checks".
> 
> Thanks to Sergei for point these out.
> 
> v2:
>  - break out replacing function arg with local var into separate patch
> 
> Phil Edworthy (3):
>   PCI: host: pcie-rcar: Use correct initial HW settings
>   PCI: host: pcie-rcar: Style and formatting changes.
>   PCI: host: pcie-rcar: Replace arg passed into a func with local var

Thanks Phil,

Acked-by: Simon Horman <horms+renesas@verge.net.au>

