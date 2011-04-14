From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 14 Apr 2011 13:50:43 +0000
Subject: Re: Linux kernel 2.6.35 webcam issue
Message-Id: <BANLkTimzjEK1BgEP65dhF+rK=YTo6R_=_g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <35FC1A56EEC91A42A0EB92079193ED8D0335279D@ASISML10.asia-idc.local>
In-Reply-To: <35FC1A56EEC91A42A0EB92079193ED8D0335279D@ASISML10.asia-idc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Feng Yang,

> On Tue, Apr 12, 2011 at 10:39 AM, Feng Yang <feng.yang.xb@renesas.com> wrote:
>> Hi
>> I have trouble in load uvc(USB Video Class) driver on SH platform.
>> I build kernel config option as below.
>> <*>   USB Gadget Support  --->
>> <M>   USB Gadget Drivers
>> <M>     USB Webcam Gadget
>>
>> #insmod /lib/modules/2.6.35/kernel/drivers/usb/gadget/g_webcam.ko
>> I insert USB cable form webcam, then I get error message as below.
>> The webcam brand is "Logitech C270"

On Thu, Apr 14, 2011 at 1:50 PM, Feng Yang <feng.yang.xb@renesas.com> wrote:
> Following is my platform information.
>
> Processor:SH7724
> Platform: Renesas MS7724 platform
> Gadget driver:R8A66597
> No local patches.

Is this a special BSP kernel or is it 2.6.35 from kernel.org?

If you have time, please consider testing latest linux-2.6 git.

Thank you!

/ magnus
