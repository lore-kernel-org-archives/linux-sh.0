From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 16 Nov 2009 10:27:21 +0000
Subject: Re: Kernel configuration for camera module
Message-Id: <aec7e5c30911160227w55745dc0ka4bc4f7b5defd34a@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <d39a29b70909160648l53dbeb1dm658b942d2aa54a24@mail.gmail.com>
In-Reply-To: <d39a29b70909160648l53dbeb1dm658b942d2aa54a24@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Johannes,

On Mon, Nov 16, 2009 at 6:29 PM, Johannes Lahti <johannes@nomasi.com> wrote:
> I copied the default kernel configuration for ap325rxa board and all
> these were set, except for the CONFIG_VIDEO_VIVI. I was able to
> compile the kernel and it seems to recognize the camera module, but I
> cannot find the device under /dev.
>
> I get these messages with dmesg:
> Linux video capture interface: v2.00
> vivi-000: V4L2 device registered as /dev/video0
> Video Technology Magazine Virtual Video Capture Board ver 0.6.0 successfully lo.
> camera 0-0: Probing 0-0
> sh_mobile_ceu sh_mobile_ceu.0: SuperH Mobile CEU driver attached to camera 0
> ov772x 0-0021: ov7725 Product ID 77:21 Manufacturer ID 7f:a2
> sh_mobile_ceu sh_mobile_ceu.0: SuperH Mobile CEU driver detached from camera 0
> camera 0-1: Probing 0-1
> sh_mobile_ceu sh_mobile_ceu.0: SuperH Mobile CEU driver attached to camera 1
> sh_mobile_ceu sh_mobile_ceu.0: SuperH Mobile CEU driver detached from camera 1
>
> But the /dev/video0 is not there. Do you know how to fix this?

It all depends on your user space setup. I suggest that you double
check that udev or mdev are running and/or manually create the v4l2
device nodes. For static systems I have some old scripts that seem to
do "mknod /dev/video0 c 81 0", but I'm not sure if it will work with
your kernel.

/ magnus
