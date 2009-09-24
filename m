From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 24 Sep 2009 06:39:50 +0000
Subject: Re: Kernel configuration for camera module
Message-Id: <aec7e5c30909232339h79914bc3q4112697743350828@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <d39a29b70909160648l53dbeb1dm658b942d2aa54a24@mail.gmail.com>
In-Reply-To: <d39a29b70909160648l53dbeb1dm658b942d2aa54a24@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Johannes,

On Wed, Sep 16, 2009 at 10:48 PM, Johannes Lahti <johannes@nomasi.com> wrote:
> Hi!
>
> I'm using AP3300 board for my development tasks and I recently got a
> camera module for it. I don't have any other info about the module
> than it has Renesas and R0P04MDLE0011RL written on it and the serial
> number.

Not sure about the board name (AP3300) and the camera module name. I
guess you are using a sh7723 based ap325rxa board?

For camera capture support you need to enable the CEU driver:
CONFIG_VIDEO_SH_MOBILE_CEU=y

The two sensors that I've seen for ap325rxa are ov772x and ncm03j.
CONFIG_SOC_CAMERA_OV772X=y
CONFIG_SOC_CAMERA_PLATFORM=y

You can enable all the options above and the code should autodetect
sensor model for you.

If you just want to play with the V4L2 interface then I recommend you
to try the vivi driver:
CONFIG_VIDEO_VIVI=y

Cheers,

/ magnus
