From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 06 Mar 2014 18:21:34 +0000
Subject: Re: [PATCH 1/9] pci-rcar-gen2: add devicetree support
Message-Id: <5318BCAE.7000108@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk> <1394128887-4197-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394128887-4197-2-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@lists.codethink.co.uk, sergei.shtylyov@cogentembedded.com, magnus.damn@opensource.se, horms@verge.net.au, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org

On 06/03/14 18:01, Ben Dooks wrote:
> Add OF match table for pci-rcar-gen2 driver for device tree support.
>

> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index fd3e3ab..1216784 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -16,6 +16,7 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/pci.h>
> +#include <linux/of_pci.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/sizes.h>

Apologies all, there's a missing include of <linux/of.h> which should
have been added here


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
