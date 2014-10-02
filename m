From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 02 Oct 2014 12:08:24 +0000
Subject: Re: [PATCH 1/2] arm: shimobile: r8a7790: add HS-USB device node
Message-Id: <542D4038.5000504@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412237073-1288-1-git-send-email-yoshihiro.shimoda.uh@renesas.com> <1412237073-1288-2-git-send-email-yoshihiro.shimoda.uh@renesas.com> <542D21BD.8020709@cogentembedded.com> <542D3998.7000303@renesas.com>
In-Reply-To: <542D3998.7000303@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 10/02/2014 03:40 PM, Yoshihiro Shimoda wrote:

>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>> ---
>>>    arch/arm/boot/dts/r8a7790.dtsi |   10 ++++++++++
>>>    1 file changed, 10 insertions(+)

>>> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
>>> index 2380fd5..fd9fc37 100644
>>> --- a/arch/arm/boot/dts/r8a7790.dtsi
>>> +++ b/arch/arm/boot/dts/r8a7790.dtsi
>>> @@ -1314,4 +1314,14 @@
>>>                ssi9: ssi@9 { interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>; };
>>>            };
>>>        };
>>> +
>>> +    hsusb: usb@e6590000 {
>>> +        compatible = "renesas,usbhs-r8a7790";
>>> +        reg = <0 0xe6590000 0 0x100>;
>>> +        interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
>>> +        clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;

>>     I don't see where are you handling this prop in the driver...

> Thank you for the point. I misunderstood this prop.
> Since the driver is using pm_runtime functions, I thought that
> this device node needs this prop.

    Ah, I've overlooked the RPM related code. No need to remove the prop then.

WBR, Sergei

