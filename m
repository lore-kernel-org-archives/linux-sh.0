From: Eduardo Valentin <edubezval@gmail.com>
Date: Thu, 17 Dec 2015 21:08:11 +0000
Subject: Re: [PATCH 0/8 v5] enable to use thermal-zone on r8a7790/1
Message-Id: <20151217210809.GE7999@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1u8qzsy.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d1u8qzsy.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Magnus <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, Dec 15, 2015 at 01:16:20AM +0000, Kuninori Morimoto wrote:
> 
> Hi
> 
> These are v5 of thermal-zone support for r8a7790/r8a7791.
> 
> Kuninori Morimoto (8):
>       1) thermal: rcar: move rcar_thermal_dt_ids to upside
>       2) thermal: rcar: check every rcar_thermal_update_temp() return value
>       3) thermal: rcar: check irq possibility in rcar_thermal_irq_xxx()
>       4) thermal: rcar: rcar_thermal_get_temp() return error if strange temp

Applied the four above

>       5) thermal: rcar: enable to use thermal-zone on DT

This one requires further discussion.

>       6) ARM: shmobile: r8a7790: enable to use thermal-zone
>       7) ARM: shmobile: r8a7791: enable to use thermal-zone

These two will go on other tree, but depend on 5. So, still on hold.

>       8) thermal: of-thermal: of_thermal_set_trip_temp() call thermal_zone_device_update()
> 

Applied number 8 too.


BR,

Eduardo 
