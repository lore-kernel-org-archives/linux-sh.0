From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 27 Feb 2014 16:34:42 +0000
Subject: Re: [PATCH] phy-rcar-gen2-usb: add device tree support
Message-Id: <530F6922.3060101@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201402270312.51588.sergei.shtylyov@cogentembedded.com> <530F626C.5020900@codethink.co.uk>
In-Reply-To: <530F626C.5020900@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, grant.likely@linaro.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-sh@vger.kernel.org, valentine.barshak@cogentembedded.com, rob@landley.net, linux-doc@vger.kernel.org

On 27-02-2014 20:06, Ben Dooks wrote:

>> Add support of the device tree probing for the Renesas R-Car generation 2 SoCs
>> documenting the device tree binding as necessary.

> You've popped in some fixes for the driver probe in here as well.

    No, I didn't -- it's all the result of not using devm_clk_get().

[...]
>> @@ -177,13 +210,19 @@ static int rcar_gen2_usb_phy_probe(struc
[...]
>> -    clk = devm_clk_get(dev, "usbhs");
>> +    if (np)
>> +        clk = of_clk_get_by_name(np, "usbhs");
>> +    else
>> +        clk = clk_get(dev, "usbhs");

> Can be removed, just add a clock-name of usbhs in the device node.

    Ah, I haven't figured out I should check clk_get() first... Yes, I'm 
adding the "clock-names" prop.

WBR, Sergei

