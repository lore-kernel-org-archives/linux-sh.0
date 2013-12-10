From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 10 Dec 2013 19:42:54 +0000
Subject: Re: [PATCH V2 0/5] pinctrl: sh-pfc: pfc-r8a7790: Update VIN groups
Message-Id: <1780188.hNGucXYrGQ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1386699626-15803-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1386699626-15803-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Valentine,

The patches are much easier to review split this way. Thank you for the great 
work.

On Tuesday 10 December 2013 22:20:21 Valentine Barshak wrote:
> This adds missing VIN pins to the pfc-r8a7790 driver, and reorganizes
> the VIN groups to cover all possible configurations of VIN data pins.
> This also groups hsync and vsync pins together and renames "field_signal"
> and "data_enable" groups to "field" and "clkenb" respectively.
> 
> Changes in version 2:
> * Split big patches into smaller series.
> * Reorganized the existing pin groups before adding new ones.
> 
> Valentine Barshak (5):
>   pinctrl: sh-pfc: pfc-r8a7790: Rename VIN pin groups
>   pinctrl: sh-pfc: pfc-r8a7790: Group VIN0 HSYNC and VSYNC together
>   pinctrl: sh-pfc: pfc-r8a7790: Reorganize VIN0 data pins
>   pinctrl: sh-pfc: pfc-r8a7790: Add missing VIN1 pins
>   pinctrl: sh-pfc: pfc-r8a7790: Add VIN2 and VIN3 pins

For the whole series,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I've applied the patches to my tree and will send a pull request for v3.14.

>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 441 +++++++++++++++++++++++++++-----
>  1 file changed, 382 insertions(+), 59 deletions(-)

-- 
Regards,

Laurent Pinchart

