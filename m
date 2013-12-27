From: Simon Horman <horms@verge.net.au>
Date: Fri, 27 Dec 2013 02:36:02 +0000
Subject: Re: [PATCH V2 0/3] arm: shmobile: koelsch: Add VIN1 camera support
Message-Id: <20131227023602.GG9184@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1388072279-12508-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1388072279-12508-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 26, 2013 at 07:37:56PM +0400, Valentine Barshak wrote:
> This adds VIN pins and clocks to R8A7791 SoC along with
> VIN1 camera support to Koelsch board.
> 
> This is probably a bit early since it depends on
> the following pending patches:
> http://marc.info/?l=linux-sh&m8807191506999&w=2
> ([PATCH V2] media: soc_camera: rcar_vin: Add preliminary R-Car M2 support)
> http://marc.info/?l=linux-sh&m8799873528360&w=2
> ([PATCH 0/3] arm: shmobile: koelsch: Add I2C support)
> 
> Changes in V2:
> * made koelsch_add_vin_device function static.
> 
> Valentine Barshak (3):
>   pinctrl: sh-pfc: r8a7791: Add VIN pins
>   arm: shmobile: r8a7791: Add VIN clocks
>   arm: shmobile: koelsch: Add VIN1 SoC camera support
> 
>  arch/arm/mach-shmobile/board-koelsch.c |  76 +++++++
>  arch/arm/mach-shmobile/clock-r8a7791.c |  10 +
>  drivers/pinctrl/sh-pfc/pfc-r8a7791.c   | 360 +++++++++++++++++++++++++++++++++
>  3 files changed, 446 insertions(+)

Hi Valentine,

a few minor points about the posting of these patches.

1. I believe that ARM: is usually in capitals in changelog subjects.

2. When posting a revised patch series please consistently number the
version of all the patches.

In this series I see something like:
	[PATCH V2 0/3]
	[PATCH 1/3]
	[PATCH 2/3]
	[PATCH V2 3/3]

Which is rather confusing (to me). Please increment the version for all
patches even if they are not changed. If you want to clarify that
they have not been changed then you can add something like the following to
their changelogs

---

v2
* No change

And then send something like:
	[PATCH V2 0/3]
	[PATCH V2 1/3]
	[PATCH V2 2/3]
	[PATCH V2 3/3]

Thanks.
