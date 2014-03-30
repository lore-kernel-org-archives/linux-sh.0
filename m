From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 30 Mar 2014 19:28:12 +0000
Subject: Re: [PATCH 8/9] ARM: shmobile: lager.dts: add usbphy reference
Message-Id: <5338704C.2030501@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk> <1394128887-4197-9-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394128887-4197-9-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk, magnus.damn@opensource.se, horms@verge.net.au, devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hello.

On 03/06/2014 09:01 PM, Ben Dooks wrote:

> Enable the usbphy node so that the phy driver is available.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
> ---
> Cc: linux-sh@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Simon Horman <horms@verge.net.au>
> ---
>   arch/arm/boot/dts/r8a7790-lager.dts | 4 ++++
>   1 file changed, 4 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index fd6851f..63d58d6 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -246,3 +246,7 @@
>   	pinctrl-0 = <&usb2_pins>;
>   	pinctrl-names = "default";
>   };
> +
> +&usbphy {
> +	status = "okay";
> +};

    I don't see why we need this patch. Why not make USB PHY always enabled?

WBR, Sergei

