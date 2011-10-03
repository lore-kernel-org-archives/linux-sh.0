From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 03 Oct 2011 04:49:14 +0000
Subject: Re: [PATCH 4/5 v2] ARM: mach-shmobile: r8a7740: Add i2c support
Message-Id: <87pqiefznd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r52ugasd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r52ugasd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

Thank you for your check

> Thanks for your work on A1 SoC support. In general I think your code
> looks good and I'm also happy to see that my i2c-sh_mobile driver can
> be used on yet another SoC.
> 
> The workaround in this patch, do you know exactly what you are fixing
> with this patch? I wonder, is it a hardware errata workaround, or is
> it a fix for a potential messy state left by the boot loader?
> 
> Perhaps the boot loader makes use of more advanced hardware features
> that the linux driver doesn't suppport yet, like DMA or HighSpeed?
> 
> Have you tried resetting the I2C channels using the SRCRn registers in
> the CPG? If not, please give it a go and see if it helps. If it helps
> then perhaps we should work on adding some generic reset support for
> the hardware blocks.

A1 chip has errata on I2C I/O pad reset, and this work-around is for it.
It is lasting errata.

Shall I add this comment on patch (v3) ?

Best regards
---
Kuninori Morimoto
