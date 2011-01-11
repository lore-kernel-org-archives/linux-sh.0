From: Yusuke Goda <yusuke.goda.sx@renesas.com>
Date: Tue, 11 Jan 2011 09:27:30 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: mackerel: Add sdhi support
Message-Id: <4D2C2282.5040109@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon-san

Sorry for the late reply.

As for AP4 and the mackerel board,
the I/O voltage of SDHI1 and MMCIF is 1.8v fixation.
So do not recognize the memory card.(Requires 3.3v)
The new memory card, 3.3v from 1.8v seems to be able to bring down.
However, AP4 and mackerel board can not support.

Perhaps that supports 1.8v eSD and eMMC would be recognized only.

Thanks,
Goda

(2010/12/23 15:36), Simon Horman wrote:
> Hi Goda-san,
> 
> The SDHI1 portions of this code do not seem to work for me.
> If I remove then then I can access SDHI0 and 2, but if they
> are included then I can't access any MMC devices.
> 
> I can access the same port that SDHI1 uses by using
> the MMCIF driver as per your subsequent patch.
> 
> Let me know if I can provide any more information.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

