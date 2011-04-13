From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Apr 2011 17:33:45 +0000
Subject: Re: Linux kernel 2.6.35 webcam issue
Message-Id: <BANLkTikJ4f7QqsLx5=w+mT3ny04zEvZ7ng@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <35FC1A56EEC91A42A0EB92079193ED8D0335279D@ASISML10.asia-idc.local>
In-Reply-To: <35FC1A56EEC91A42A0EB92079193ED8D0335279D@ASISML10.asia-idc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Feng Yang,

On Tue, Apr 12, 2011 at 10:39 AM, Feng Yang <feng.yang.xb@renesas.com> wrot=
e:
> Hi
> I have trouble in load uvc(USB Video Class) driver on SH platform.
> I build kernel config option as below.
> <*> =A0 USB Gadget Support =A0--->
> <M> =A0 USB Gadget Drivers
> <M> =A0 =A0 USB Webcam Gadget
>
> #insmod /lib/modules/2.6.35/kernel/drivers/usb/gadget/g_webcam.ko
> I insert USB cable form webcam, then I get error message as below.
> The webcam brand is "Logitech C270"

Which processor or board are you experiencing this on? Which gadget
driver? Maybe you are using the r866597 gadget driver? Any local
patches?

Please provide more information.

Thanks,

/ magnus
