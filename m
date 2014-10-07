From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 07 Oct 2014 19:15:50 +0000
Subject: Re: [PATCH v2 2/2] arm: shmobile: lager: enable HS-USB
Message-Id: <54343BE6.2020903@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412680220-4552-1-git-send-email-yoshihiro.shimoda.uh@renesas.com> <1412680220-4552-3-git-send-email-yoshihiro.shimoda.uh@renesas.com> <5433D18B.6050208@cogentembedded.com> <5433DA52.2020005@renesas.com>
In-Reply-To: <5433DA52.2020005@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 10/07/2014 04:19 PM, Yoshihiro Shimoda wrote:

>>> Since this board doesn't have USB ID pin, we assumes the GP5_18 (USB0_PWEN)
>>> is an ID pin because the gpio is high when the SW5 is Pin 3 side.

>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>> ---
>>>    arch/arm/boot/dts/r8a7790-lager.dts |    5 +++++
>>>    1 file changed, 5 insertions(+)

>>> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
>>> index 719979e..011254a 100644
>>> --- a/arch/arm/boot/dts/r8a7790-lager.dts
>>> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
>>> @@ -446,3 +446,8 @@
>>>            };
>>>        };
>>>    };
>>> +
>>> +&hsusb {
>>> +    status = "okay";
>>> +    renesas,enable-gpio = <&gpio5 18 GPIO_ACTIVE_HIGH>;
>>> +};

>>     As I said before, this is not enough. We need pinctrl-related props. Same is true for other boards.

> Thank you very much for the point again.
> Finally I understood what you said before.
> I will start studying the pinctrl world.

    Looks like it will be quicker if I post v3 of your patches.

    Unfortunately, there'll be pinctrl-related error messages in the log if 
the internal PCI and HS-USB drivers are enabled together but everything should 
still work.

> Best regards,
> Yoshihiro Shimoda

WBR, Sergei

