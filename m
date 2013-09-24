From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 24 Sep 2013 16:14:44 +0000
Subject: Re: [PATCH 0/3] media: Add SH-Mobile RCAR-H2 Lager board support
Message-Id: <Pine.LNX.4.64.1309241812350.22197@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1380029916-10331-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380029916-10331-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Valentine,

Since patches 2 and 3 here are for soc-camera, I can offer to take all 3 
via my tree after all comments to patch 1/3 are addressed and someone 
(Laurent?) has acked it. Alternatively I can ack the two patches and let 
all 3 go via another tree, or we can split this series too - no problem 
with me either way.

Thanks
Guennadi

On Tue, 24 Sep 2013, Valentine Barshak wrote:

> The following patches add ADV7611/ADV7612 HDMI receiver I2C driver
> and add RCAR H2 SOC support along with ADV761x output format support
> to rcar_vin soc_camera driver.
> 
> These changes are needed for SH-Mobile R8A7790 Lager board
> video input support.
> 
> Valentine Barshak (3):
>   media: i2c: Add ADV761X support
>   media: rcar_vin: Add preliminary r8a7790 H2 support
>   media: rcar_vin: Add RGB888_1X24 input format support
> 
>  drivers/media/i2c/Kconfig                    |   11 +
>  drivers/media/i2c/Makefile                   |    1 +
>  drivers/media/i2c/adv761x.c                  | 1060 ++++++++++++++++++++++++++
>  drivers/media/platform/soc_camera/rcar_vin.c |   17 +-
>  include/media/adv761x.h                      |   28 +
>  5 files changed, 1114 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/media/i2c/adv761x.c
>  create mode 100644 include/media/adv761x.h
> 
> -- 
> 1.8.3.1
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
