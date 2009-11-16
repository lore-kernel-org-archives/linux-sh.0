From: Johannes Lahti <johannes@nomasi.com>
Date: Mon, 16 Nov 2009 09:29:31 +0000
Subject: Re: Kernel configuration for camera module
Message-Id: <d39a29b70911160129l74b0fc4xaf93d90a38f3e645@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <d39a29b70909160648l53dbeb1dm658b942d2aa54a24@mail.gmail.com>
In-Reply-To: <d39a29b70909160648l53dbeb1dm658b942d2aa54a24@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus!

Sorry for the delay, there was more urgent things to do in our project
and I couldn't get back to this issue until today.

2009/9/24 Magnus Damm <magnus.damm@gmail.com>:

> Not sure about the board name (AP3300) and the camera module name. I
> guess you are using a sh7723 based ap325rxa board?

Yeah, that's it. AP3300 is written in the back of the board.

> For camera capture support you need to enable the CEU driver:
> CONFIG_VIDEO_SH_MOBILE_CEU=y
>
> The two sensors that I've seen for ap325rxa are ov772x and ncm03j.
> CONFIG_SOC_CAMERA_OV772X=y
> CONFIG_SOC_CAMERA_PLATFORM=y
>
> You can enable all the options above and the code should autodetect
> sensor model for you.
>
> If you just want to play with the V4L2 interface then I recommend you
> to try the vivi driver:
> CONFIG_VIDEO_VIVI=y

I copied the default kernel configuration for ap325rxa board and all
these were set, except for the CONFIG_VIDEO_VIVI. I was able to
compile the kernel and it seems to recognize the camera module, but I
cannot find the device under /dev.

I get these messages with dmesg:
Linux video capture interface: v2.00
vivi-000: V4L2 device registered as /dev/video0
Video Technology Magazine Virtual Video Capture Board ver 0.6.0 successfully lo.
camera 0-0: Probing 0-0
sh_mobile_ceu sh_mobile_ceu.0: SuperH Mobile CEU driver attached to camera 0
ov772x 0-0021: ov7725 Product ID 77:21 Manufacturer ID 7f:a2
sh_mobile_ceu sh_mobile_ceu.0: SuperH Mobile CEU driver detached from camera 0
camera 0-1: Probing 0-1
sh_mobile_ceu sh_mobile_ceu.0: SuperH Mobile CEU driver attached to camera 1
sh_mobile_ceu sh_mobile_ceu.0: SuperH Mobile CEU driver detached from camera 1

But the /dev/video0 is not there. Do you know how to fix this?

Cheers!
-Johannes
