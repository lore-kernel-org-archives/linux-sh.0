From: Rob Herring <robh@kernel.org>
Date: Mon, 14 Dec 2015 22:21:48 +0000
Subject: Re: [PATCH v2] extcon: add Maxim MAX3355 driver
Message-Id: <CAL_JsqJ2RQcJY27B=emzKT6HQ4XEp=XjSqufx5742yvFt3Wfxw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5045536.UEVncNCOZE@wasted.cogentembedded.com> <20151214012400.GA9506@rob-hp-laptop>
 <566EFE0A.4000104@cogentembedded.com>
In-Reply-To: <566EFE0A.4000104-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux USB List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, Dec 14, 2015 at 11:36 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
> On 12/14/2015 04:24 AM, Rob Herring wrote:
>
>>> Maxim  Integrated MAX3355E chip integrates a  charge pump and comparators
>>> to
>>> enable a system with an integrated USB OTG dual-role transceiver to
>>> function
>>> as  an USB  OTG dual-role device.  In addition  to sensing/controlling
>>> Vbus,
>>> the chip also passes thru the ID signal  from the USB  OTG connector.
>>> On some Renesas boards,  this signal is  just fed into the SoC thru a
>>> GPIO
>>> pin --  there's no real  OTG controller, only host and gadget USB
>>> controllers
>>> sharing the same USB bus; however, we'd  like to allow host or gadget
>>> drivers
>>> to be loaded depending on the cable type,  hence the need for the MAX3355
>>> extcon driver. The Vbus status signals are also  wired to GPIOs (however,
>>> we
>>> aren't currently interested in them),  the OFFVBUS# signal is controlled
>>> by
>>> the host controllers, there's  also the SHDN# signal wired to a GPIO, it
>>> should be driven high for the  normal operation.
>>
>>
>> As multiple people have said, fix the spacing here.
>
>
>    You are the first to complain abou _this_ patch. If you don't have other
> issues with this driver in which case you should have trimmed the reply at
> this point), I'd like to keep my spacing as is. Thank you.

Your previous version was not "extcon-usb-gpio: add enable pin
support"[1] which has now been re-written to be max3355 specific? "So
what" and "I'd like to keep my spacing as is" aren't valid reasons.
Fix it, then I'll look at the rest again.

Rob

[1] https://patchwork.ozlabs.org/patch/555378/
