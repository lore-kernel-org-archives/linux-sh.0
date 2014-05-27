From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 27 May 2014 09:29:41 +0000
Subject: Re: [PATCH v4] phy: Renesas R-Car Gen2 PHY driver
Message-Id: <53845B05.80900@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201405240206.04700.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201405240206.04700.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "kishon@ti.com" <kishon@ti.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "rdunlap@infradead.org" <rdunlap@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi,

(2014/05/24 7:06), Sergei Shtylyov wrote:
< snip >
> +Example (Lager board):
> +
> +	usb-phy@e6590100 {
> +		compatible = "renesas,usb-phy-r8a7790";
> +		reg = <0 0xe6590100 0 0x100>;
> +		#phy-cells = <2>;
> +		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
> +		clock-names = "usbhs";

I'm not sure about the clock-names string,
but the current clock-name of R8A7790_CLK_HSUSB is "hsusb" in r8a7790.dtsi.
So, before I tested this driver, I changed the "hsusb" to "usbhs".
Otherwise, the devm_clk_get() in the driver failed.

< snip >
> +	for_each_child_of_node(dev->of_node, np) {
> +  		struct rcar_gen2_phy *phy;

This line has two while spaces at the start of the line.

Best regards,
Yoshihiro Shimoda
