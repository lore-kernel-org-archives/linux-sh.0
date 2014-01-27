From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 27 Jan 2014 12:48:29 +0000
Subject: Re: [PATCH 1/8] pci-rcar-gen2: add of match table
Message-Id: <52E6559D.6090708@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390754945-28142-1-git-send-email-ben.dooks@codethink.co.uk> <1390754945-28142-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390754945-28142-2-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk
Cc: Bjorn Helgaas <bhelgaas@google.com>, Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

Hello.

On 26-01-2014 20:48, Ben Dooks wrote:

> Add OF match table for pci-rcar-gen2 driver for device tree support.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>   drivers/pci/host/pci-rcar-gen2.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index ceec147..ea65bac 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -311,9 +311,17 @@ static int __init rcar_pci_probe(struct platform_device *pdev)
>   	return rcar_pci_add_controller(priv);
>   }
>
> +static struct of_device_id rcar_pci_of_match[] = {
> +	{ .compatible = "renesas,pci-r8a7790", },

    Why only H2 SoC, if the driver is for both Gen2 SoCs?

WBR, Sergei

