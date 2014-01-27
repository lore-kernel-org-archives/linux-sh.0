From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 27 Jan 2014 17:23:54 +0000
Subject: Re: [PATCH] phy-rcar-usb-gen2: add device tree support
Message-Id: <52E6A436.5090408@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390754945-28142-6-git-send-email-ben.dooks@codethink.co.uk> <1390755901-3743-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390755901-3743-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk
Cc: linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, devicetree@vger.kernel.org

Hello.

On 01/26/2014 08:05 PM, Ben Dooks wrote:

> Add support for the phy-rcar-gen2-usb driver to be probed from device tree.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
> ---
> Fixes from v2:
> 	- fix missing of_if patch
> (I clearly should not be let near git-rebase when hungry)

> Fixes from v1:
> 	- use of_property_reasd-bool()
> 	- remove unused of_id variable

> Cc: linux-usb@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: devicetree@vger.kernel.org
> ---
>   drivers/usb/phy/phy-rcar-gen2-usb.c | 31 ++++++++++++++++++++++++++-----
>   1 file changed, 26 insertions(+), 5 deletions(-)

> diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c b/drivers/usb/phy/phy-rcar-gen2-usb.c
> index db3ab34..e4665b9 100644
> --- a/drivers/usb/phy/phy-rcar-gen2-usb.c
> +++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
[...]
> @@ -167,6 +168,12 @@ out:
>   	spin_unlock_irqrestore(&priv->lock, flags);
>   }
>
> +static struct of_device_id rcar_gen2_usb_phy_ofmatch[] = {
> +	{ .compatible = "renesas,usb-phy-r8a7790", },
> +	{ .compatible = "renesas,rcar-gen2-usb-phy", },

    Frankly speaking, I don't understand the need for the clearly duplicate 
entries.

WBR, Sergei

