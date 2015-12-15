From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 15 Dec 2015 11:24:56 +0000
Subject: Re: [PATCH v2] extcon: add Maxim MAX3355 driver
Message-Id: <566FF888.8060200@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5045536.UEVncNCOZE@wasted.cogentembedded.com>
 <20151214012400.GA9506@rob-hp-laptop> <566EFE0A.4000104@cogentembedded.com>
 <CAL_JsqJ2RQcJY27B=emzKT6HQ4XEp=XjSqufx5742yvFt3Wfxw@mail.gmail.com>
 <566F42BF.30109@cogentembedded.com> <20151214234446.GA10671@kroah.com>
In-Reply-To: <20151214234446.GA10671@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Rob Herring <robh@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>

Hello.

On 12/15/2015 2:44 AM, Greg KH wrote:

>>>>>> Maxim  Integrated MAX3355E chip integrates a  charge pump and comparators
>>>>>> to
>>>>>> enable a system with an integrated USB OTG dual-role transceiver to
>>>>>> function
>>>>>> as  an USB  OTG dual-role device.  In addition  to sensing/controlling
>>>>>> Vbus,
>>>>>> the chip also passes thru the ID signal  from the USB  OTG connector.
>>>>>> On some Renesas boards,  this signal is  just fed into the SoC thru a
>>>>>> GPIO
>>>>>> pin --  there's no real  OTG controller, only host and gadget USB
>>>>>> controllers
>>>>>> sharing the same USB bus; however, we'd  like to allow host or gadget
>>>>>> drivers
>>>>>> to be loaded depending on the cable type,  hence the need for the MAX3355
>>>>>> extcon driver. The Vbus status signals are also  wired to GPIOs (however,
>>>>>> we
>>>>>> aren't currently interested in them),  the OFFVBUS# signal is controlled
>>>>>> by
>>>>>> the host controllers, there's  also the SHDN# signal wired to a GPIO, it
>>>>>> should be driven high for the  normal operation.
>>>>>
>>>>>
>>>>> As multiple people have said, fix the spacing here.
>>>>
>>>>
>>>>     You are the first to complain abou _this_ patch. If you don't have other
>>>> issues with this driver in which case you should have trimmed the reply at
>>>> this point), I'd like to keep my spacing as is. Thank you.
>>>
>>> Your previous version was not "extcon-usb-gpio: add enable pin
>>> support"[1] which has now been re-written to be max3355 specific?
>>
>>     No, the MAX3355 driver pre-dates that version. First there was a driver,
>> then I tried to re-use the existing stuff (there was no extcon-usb-gpio at
>> the time of writing my driver), then had to return to the separate driver
>> idea...
>>
>>> "So
>>> what" and "I'd like to keep my spacing as is" aren't valid reasons.
>>> Fix it, then I'll look at the rest again.
>>
>>     I'll consider doing that if you care to explain what's the problem with
>> my spacing. TIA.
>
> You are mixing 2 and 1 spaces between words, don't do that.

    Care to just explain why?

MBR, Sergei

