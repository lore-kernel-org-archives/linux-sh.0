From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 01 Aug 2014 13:35:51 +0000
Subject: Re: [PATCH 1/2] usb: renesas_usbhs: Add device tree bindings documentation
Message-Id: <53DB97B7.2090203@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <53DB7EBA.3080004@renesas.com>
In-Reply-To: <53DB7EBA.3080004-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hello.

On 08/01/2014 03:49 PM, Yoshihiro Shimoda wrote:

> Document the device tree bindings for the Renesas USBHS controller.

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>   .../devicetree/bindings/usb/renesas_usbhs.txt      |   24 ++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/usb/renesas_usbhs.txt

> diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> new file mode 100644
> index 0000000..e9faa65
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> @@ -0,0 +1,24 @@
> +Renesas Electronics USBHS driver
> +
> +Required properties:
> +  - compatible: Must contain one of the following:
> +	- "renesas,usbhs-r8a7790"
> +	- "renesas,usbhs-r8a7791"
> +  - reg: Base address and length of the register for the USBHS
> +  - interrupts: Interrupt specifier for the USBHS
> +  - clocks: A list of phandle + clock specifier pairs
> +
> +Optional properties:
> +  - buswait_bwait: Integer to use BUSWAIT register

   Should be named "renesas,buswait-bwait" or probably just "renesas,buswait".

> +  - enable-gpio: A gpio specifier to check GPIO determining if USB function

   Should also be prefixed with "renesas,".

[...]

WBR, Sergei

