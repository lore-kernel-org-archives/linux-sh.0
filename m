From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 14 Dec 2015 17:36:10 +0000
Subject: Re: [PATCH v2] extcon: add Maxim MAX3355 driver
Message-Id: <566EFE0A.4000104@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5045536.UEVncNCOZE@wasted.cogentembedded.com>
 <20151214012400.GA9506@rob-hp-laptop>
In-Reply-To: <20151214012400.GA9506@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org

Hello.

On 12/14/2015 04:24 AM, Rob Herring wrote:

>> Maxim  Integrated MAX3355E chip integrates a  charge pump and comparators to
>> enable a system with an integrated USB OTG dual-role transceiver to function
>> as  an USB  OTG dual-role device.  In addition  to sensing/controlling Vbus,
>> the chip also passes thru the ID signal  from the USB  OTG connector.
>> On some Renesas boards,  this signal is  just fed into the SoC thru a GPIO
>> pin --  there's no real  OTG controller, only host and gadget USB controllers
>> sharing the same USB bus; however, we'd  like to allow host or gadget drivers
>> to be loaded depending on the cable type,  hence the need for the MAX3355
>> extcon driver. The Vbus status signals are also  wired to GPIOs (however, we
>> aren't currently interested in them),  the OFFVBUS# signal is controlled  by
>> the host controllers, there's  also the SHDN# signal wired to a GPIO, it
>> should be driven high for the  normal operation.
>
> As multiple people have said, fix the spacing here.

    You are the first to complain abou _this_ patch. If you don't have other 
issues with this driver in which case you should have trimmed the reply at 
this point), I'd like to keep my spacing as is. Thank you.

MBR, Sergei

