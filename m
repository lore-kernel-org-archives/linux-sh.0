From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 10 Dec 2013 15:57:29 +0000
Subject: Re: [PATCH 0/2] pinctrl: sh-pfc: pfc-r8a7790: Update VIN groups
Message-Id: <46236720.8xf39Ejjqp@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1386690611-2014-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1386690611-2014-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Valentine,

Thank you for the patches.

On Tuesday 10 December 2013 19:50:09 Valentine Barshak wrote:
> This adds missing VIN pins to the pfc-r8a7790 driver and reorganizes
> the VIN groups to cover all possible configurations of VIN data pins.
> This also groups hsync and vsync pins together and renames "field_signal"
> and "data_enable" groups to "field" and "clkenb" respectively.
> 
> Valentine Barshak (2):
>   pinctrl: sh-pfc: pfc-r8a7790: Add full VIN1/2/3 support
>   pinctrl: sh-pfc: pfc-r8a7790: Reorganize and rename VIN pin groups

From a review point of view it would make my life much easier if you could 
switch the patches order. The reason is that patch 2/2 is currently pretty big 
because 1/2 comes first. Inverting them would make the reorganization patch 
simpler, and would make the VIN1/2/3 support patch cleaner.

>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 441 +++++++++++++++++++++++++++-----
>  1 file changed, 382 insertions(+), 59 deletions(-)

-- 
Regards,

Laurent Pinchart

