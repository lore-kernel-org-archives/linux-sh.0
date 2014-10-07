From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 07 Oct 2014 21:00:35 +0000
Subject: Re: [PATCH v3 2/2] ARM: shmobile: lager: enable HS-USB
Message-Id: <54345473.8060305@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2438577.UAUDMkTTWI@wasted.cogentembedded.com>
 <2298118.7qjLAFjuvd@wasted.cogentembedded.com>
In-Reply-To: <2298118.7qjLAFjuvd@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 10/08/2014 12:26 AM, Sergei Shtylyov wrote:

> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

> Enable HS-USB device for the Lager board, defining the GPIO that the driver
> should check when probing. Since this board doesn't have the OTG ID pin, we
> assume that GP5_18 (USB0_PWEN) is an ID pin because it is 1 when the SW5 is
> in position 2-3 (meaning USB function) and 0 in other positions.

> Note that there will be pinctrl-related error messages if both internal PCI
> and HS-USB drivers are enabled but they should be just ignored.

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> [Sergei: added pin function/group and prop, moved device node, fixed summary,
> supplemented changelog]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
> Changes in version 3:
> - added pin function/group and the pinctrl-related prop;
> - moved the HS-USB node to precede the USB PHY node;
> - uppercased "arm" in the summary;
> - supplemented changelog.

>   arch/arm/boot/dts/r8a7790-lager.dts |   12 ++++++++++++
>   1 file changed, 12 insertions(+)

> Index: renesas/arch/arm/boot/dts/r8a7790-lager.dts
> =================================> --- renesas.orig/arch/arm/boot/dts/r8a7790-lager.dts
> +++ renesas/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -226,6 +226,11 @@
>   		renesas,function = "usb0";
>   	};
>
> +	hsusb_pins: usb0 {

    Oops, forgot to rename the node. :-/ Although dtc didn't protest.

WBR, Sergei

