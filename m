From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 04 Jan 2018 22:28:03 +0000
Subject: Re: [PATCH v3 1/9] dt-bindings: media: Add Renesas CEU bindings
Message-Id: <14433032.8RBNSVMmkm@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1515081797-17174-1-git-send-email-jacopo+renesas@jmondi.org> <1515081797-17174-2-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1515081797-17174-2-git-send-email-jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
Cc: magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, geert-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sakari.ailus-X3B1VOXEql0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Jacopo,

Thank you for the patch.

On Thursday, 4 January 2018 18:03:09 EET Jacopo Mondi wrote:
> Add bindings documentation for Renesas Capture Engine Unit (CEU).
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  .../devicetree/bindings/media/renesas,ceu.txt      | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/renesas,ceu.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/renesas,ceu.txt
> b/Documentation/devicetree/bindings/media/renesas,ceu.txt new file mode
> 100644
> index 0000000..a4f3c05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/renesas,ceu.txt
> @@ -0,0 +1,85 @@
> +Renesas Capture Engine Unit (CEU)
> +----------------------------------------------
> +
> +The Capture Engine Unit is the image capture interface found in the Renesas
> +SH Mobile and RZ SoCs.
> +
> +The interface supports a single parallel input with data bus width of 8 or
> 16
> +bits.
> +
> +Required properties:
> +- compatible: Must be one of the following.
> +	- "renesas,r7s72100-ceu" for CEU units found in R7S72100 (RZ/A1) SoCs.
> +	- "renesas,ceu" as a generic fallback.

As asked in my review of patch 3/9, what's your policy for compatible strings 
? As far as I understand there's no generic CEU, as the SH4 and RZ versions 
are not compatible. Should the "renesas,ceu" compatible string then be 
replaced by "renesas,rz-ceu" ?

> +       SH Mobile CPUs do not currently support OF, and they configure their
> +	CEU interfaces using platform data. The "compatible" list will be
> +	expanded once SH Mobile will be made OF-capable.

The first sentence is out of scope, or at least its second half. I'd drop this 
completely, or possibly capture it in the commit message.

> +- reg: Registers address base and size.
> +- interrupts: The interrupt specifier.
> +
> +The CEU supports a single parallel input and should contain a single 'port'
> +subnode with a single 'endpoint'. Connection to input devices are modeled
> +according to the video interfaces OF bindings specified in:
> +Documentation/devicetree/bindings/media/video-interfaces.txt
> +
> +Optional endpoint properties applicable to parallel input bus described in
> +the above mentioned "video-interfaces.txt" file are supported by this
> driver:

I know it's hard to get rid of that habit, but drivers are out of scope for DT 
bindings so they should not be mentioned. You should of course document the 
properties, and explain whether they are mandatory and optional.

> +
> +- hsync-active: Active state of the HSYNC signal, 0/1 for LOW/HIGH
> respectively.
> +- vsync-active: Active state of the VSYNC signal, 0/1 for LOW/HIGH
> respectively.
> +
> +Example:
> +
> +The example describes the connection between the Capture Engine Unit and an
> +OV7670 image sensor connected to i2c1 interface.
> +
> +ceu: ceu@e8210000 {
> +	reg = <0xe8210000 0x209c>;
> +	compatible = "renesas,ceu";

Don't forget to update this example when you'll address my comment about 
compatible strings.

> +	interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&vio_pins>;
> +
> +	status = "okay";
> +
> +	port {
> +		ceu_in: endpoint {
> +			remote-endpoint = <&ov7670_out>;
> +
> +			hsync-active = <1>;
> +			vsync-active = <0>;
> +		};
> +	};
> +};
> +
> +i2c1: i2c@fcfee400 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +
> +	status = "okay";
> +
> +	clock-frequency = <100000>;
> +
> +	ov7670: camera@21 {
> +		compatible = "ovti,ov7670";
> +		reg = <0x21>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vio_pins>;
> +
> +		reset-gpios = <&port3 11 GPIO_ACTIVE_LOW>;
> +		powerdown-gpios = <&port3 12 GPIO_ACTIVE_HIGH>;
> +
> +		port {
> +			ov7670_out: endpoint {
> +				remote-endpoint = <&ceu_in>;
> +
> +				hsync-active = <1>;
> +				vsync-active = <0>;
> +			};
> +		};
> +	};
> +};

-- 
Regards,

Laurent Pinchart

