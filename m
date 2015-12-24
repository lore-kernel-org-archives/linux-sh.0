From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 24 Dec 2015 19:54:30 +0000
Subject: Re: [PATCH v5 09/14] ARM: shmobile: koelsch: Enable DU device in DT
Message-Id: <567C4D76.2010602@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414332679-15497-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414332679-15497-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/26/2014 05:11 PM, Laurent Pinchart wrote:

> Specify the DU output topology, enable the DU device and configure the
> related pins.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   arch/arm/boot/dts/r8a7791-koelsch.dts | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> index 53184637f160..0402c498b05b 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -212,14 +212,24 @@
>   	};
>   };
>
> +&du {
> +	pinctrl-0 = <&du_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			lvds_connector: endpoint {

    I don't understand what this unreferenced label achieves. Also, the 
Koelsch schematics tells me LVDS is connected to DU0, not DU1...

[...]

MBR, Sergei

