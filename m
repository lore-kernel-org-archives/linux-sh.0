From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 23 Dec 2014 19:41:49 +0000
Subject: Re: [PATCH v2] renesas_usbhs: fix platform init error message
Message-Id: <5499C57D.8020303@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
In-Reply-To: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 12/23/2014 10:17 PM, Felipe Balbi wrote:

[...]

>>>>>>>>> There is a typo ("prove" instead of "probe") in the error message printed when
>>>>>>>>> the platform initialization fails. Replace that word with more fitting "init".

>>>>>>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>>>>>>>> this actually goes through me, I'll take it in a bit.

>>>>>>>      Er, OK. Could you update MAINTAINERS?

>>>>>> there is no entry for renesas driver in MAINTAINERS.

>>>>>> Shimoda-san, care to send a patch adding yourself or Morimoto-san as
>>>>>> maintainers for Renesas driver and pointing to my tree in kernel.org ?

>>>>> I would like to move the renesas_usbhs driver to drivers/usb/gadget/udc somehow.
>>>>> Because the driver is almost used for a gadget driver.
>>>>> The driver has a host driver support now. But, it is not used recently.

>>>>> After that, this MAINTAINERS issue becomes clear, I think.
>>>>> Felipe-san and Sergei-san, what do you think?

>>>>      I'm against such move.

>>> Thank you for the reply. But, I would like to know why you are against such move.

>>     Because we still need the host mode; RZ/A1H (R7S72100) SoC should need it
>> soon), and bi-modal USBHS hardware is better placed in its own directory.

> yeah, I'll agree with Sergei here. All other dual role IPs have their

    Thanks. :-)

> own directories (musb, dwc3, dwc2, isp1760, chipidea...).

    However, I'm only seeing ISP1760 files in drivers/usb/host/...

WBR, Sergei

