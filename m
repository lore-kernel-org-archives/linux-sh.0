From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 28 Jan 2014 15:11:32 +0000
Subject: Re: [PATCH 1/3] PCI: rcar: check platform_get_irq() return code
Message-Id: <52E7D6B5.6000003@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390902468-7753-1-git-send-email-ben.dooks@codethink.co.uk> <1390902468-7753-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390902468-7753-2-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 01/28/2014 12:47 PM, Ben Dooks wrote:

> The current code does not check the return from platform_get_irq()
> so add an error check and return if this call does fail.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> ---
>   drivers/pci/host/pci-rcar-gen2.c | 5 +++++
>   1 file changed, 5 insertions(+)

> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index ea65bac..674f7fe 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -308,6 +308,11 @@ static int __init rcar_pci_probe(struct platform_device *pdev)
>   	priv->reg = reg;
>   	priv->dev = &pdev->dev;
>
> +	if (priv->irq < 0) {

    <= actually, as IRQ0 has been declared invalid by Linus.

> +		dev_err(&pdev->dev, "no valid irq found\n");
> +		return priv->irq;
> +	}
> +

WBR, Sergei


