From: Simon Horman <horms@verge.net.au>
Date: Mon, 06 Jan 2014 07:53:51 +0000
Subject: Re: [PATCH V3 0/3] ARM: shmobile: koelsch: Add VIN1 camera support
Message-Id: <20140106075351.GL24653@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1388145471-9361-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1388145471-9361-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 27, 2013 at 03:57:48PM +0400, Valentine Barshak wrote:
> This adds VIN pins and clocks to R8A7791 SoC along with
> VIN1 camera support to Koelsch board.
> 
> This is probably a bit early since it depends on
> the following pending patches:
> http://marc.info/?l=linux-sh&m8807191506999&w=2
> ([PATCH V2] media: soc_camera: rcar_vin: Add preliminary R-Car M2 support)
> http://marc.info/?l=linux-sh&m8814366919427&w=2
> ([PATCH 0/3 V2] ARM: shmobile: koelsch: Add I2C support)
> 
> Changes in V2:
> * made koelsch_add_vin_device function static.
> 
> Changes in V3:
> * capitalized ARM in the subject.
> 
> Valentine Barshak (3):
>   pinctrl: sh-pfc: r8a7791: Add VIN pins

Laurent has queued this up.

>   ARM: shmobile: r8a7791: Add VIN clocks

I will queue this up.

>   ARM: shmobile: koelsch: Add VIN1 SoC camera support

Please repost this once the dependencies are present in either
an rc release or my devel branch. Please also include a patch
to update the koelsch defconfig to enable VIN.

>  arch/arm/mach-shmobile/board-koelsch.c |  76 +++++++
>  arch/arm/mach-shmobile/clock-r8a7791.c |  10 +
>  drivers/pinctrl/sh-pfc/pfc-r8a7791.c   | 360 +++++++++++++++++++++++++++++++++
>  3 files changed, 446 insertions(+)
> 
> -- 
> 1.8.3.1
> 
