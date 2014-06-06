From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 06 Jun 2014 20:57:17 +0000
Subject: Re: [PATCH v3 4/7] ARM: lager: add vin1 node
Message-Id: <53922B2D.6040400@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397471802-27216-5-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397471802-27216-5-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 04/14/2014 02:36 PM, Ben Dooks wrote:

> Add device-tree for vin1 (composite video in) on the
> lager board.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   arch/arm/boot/dts/r8a7790-lager.dts | 38 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index a087421..6888866 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
[...]
> @@ -239,8 +244,41 @@
>   	status = "ok";
>   	pinctrl-0 = <&i2c2_pins>;
>   	pinctrl-names = "default";
> +
> +	adv7180: composite-in@0x20 {

    Please drop "0x" from the unit-addresspart of the node name.

WBR, Sergei

