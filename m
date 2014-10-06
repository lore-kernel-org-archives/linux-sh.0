From: Simon Horman <horms@verge.net.au>
Date: Mon, 06 Oct 2014 01:47:12 +0000
Subject: Re: [PATCH 2/2] arm: shmobile: lager: enable HS-USB
Message-Id: <20141006014712.GA22040@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1412237073-1288-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1412237073-1288-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <542EFDEA.2030906@cogentembedded.com>
 <5431E984.6000203@renesas.com>
In-Reply-To: <5431E984.6000203@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Mon, Oct 06, 2014 at 09:59:48AM +0900, Yoshihiro Shimoda wrote:
> Hello.
> 
> (2014/10/04 4:50), Sergei Shtylyov wrote:
> > On 10/02/2014 12:04 PM, Yoshihiro Shimoda wrote:
> > 
> >> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >> ---
> >>   arch/arm/boot/dts/r8a7790-lager.dts |    5 +++++
> >>   1 file changed, 5 insertions(+)
> > 
> >> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> >> index 1698591..4badd0a 100644
> >> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> >> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> >> @@ -445,3 +445,8 @@
> >>   		};
> >>   	};
> >>   };
> >> +
> >> +&hsusb {
> >> +	status = "okay";
> >> +	renesas,enable-gpio = <&gpio5 18 GPIO_ACTIVE_LOW>;
> > 
> >     It's certainly active-high.
> 
> Since the current code has the following, we have to set the active_low...
> However, the code is unreadable, I think. So, I will modify the code.

It seems to me that would be best.

As far as possible the bindings and their use should
describe the hardware rather than the software.

> 	/* check GPIO determining if USB function should be enabled */
> 	if (priv->dparam.enable_gpio) {
> 		gpio_request_one(priv->dparam.enable_gpio, GPIOF_IN, NULL);
> 		ret = !gpio_get_value(priv->dparam.enable_gpio);
> 		gpio_free(priv->dparam.enable_gpio);
> 		if (ret) {
> 			dev_warn(&pdev->dev,
> 				 "USB function not selected (GPIO %d)\n",
> 				 priv->dparam.enable_gpio);
> 			ret = -ENOTSUPP;
> 			goto probe_end_mod_exit;
> 		}
> 	}
> 
> Best regards,
> Yoshihiro Shimoda
> 
> > WBR, Sergei
> > 
> 
