From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 15 Dec 2015 19:11:47 +0000
Subject: Re: [PATCH v2] extcon: add Maxim MAX3355 driver
Message-Id: <567065F3.6010009@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5045536.UEVncNCOZE@wasted.cogentembedded.com>
 <566F6AEC.1030903@samsung.com>
In-Reply-To: <566F6AEC.1030903@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chanwoo Choi <cw00.choi@samsung.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, myungjoo.ham@samsung.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-usb@vger.kernel.org

On 12/15/2015 04:20 AM, Chanwoo Choi wrote:

>> Maxim  Integrated MAX3355E chip integrates a  charge pump and comparators to
>         ^^                                     ^^
>> enable a system with an integrated USB OTG dual-role transceiver to function
>> as  an USB  OTG dual-role device.  In addition  to sensing/controlling Vbus,
>      ^^      ^^                     ^^           ^^
>> the chip also passes thru the ID signal  from the USB  OTG connector.
>                                           ^^
>> On some Renesas boards,  this signal is  just fed into the SoC thru a GPIO
>                           ^^              ^^
>> pin --  there's no real  OTG controller, only host and gadget USB controllers
>          ^^               ^^
>> sharing the same USB bus; however, we'd  like to allow host or gadget drivers
>                                           ^^
>> to be loaded depending on the cable type,  hence the need for the MAX3355
>                                             ^^
>> extcon driver. The Vbus status signals are also  wired to GPIOs (however, we
>> aren't currently interested in them),  the OFFVBUS# signal is controlled  by
>                                         ^^                                 ^^
>> the host controllers, there's  also the SHDN# signal wired to a GPIO, it
>                                 ^^
>> should be driven high for the  normal operation.
>                                 ^^
> As above '^' expression, you used the double space between words.
> You should fix it.

    OK, since so many people seem to be offended by that, I'll fix it. 
Meanwhile, please comment on the patch itself.

> Thanks,
> Chanwoo Choi
[...]

MBR, Sergei

