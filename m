From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 18 Jul 2008 07:39:54 +0000
Subject: Re: [PATCH 05/06] sh_mobile_ceu_camera: Add SuperH Mobile CEU driver
Message-Id: <Pine.LNX.4.64.0807180918160.13569@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20080714120204.4806.87287.sendpatchset@rx1.opensource.se>
	<20080714120249.4806.66136.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080714120249.4806.66136.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: video4linux-list@redhat.com, paulius.zaleckas@teltonika.lt, linux-sh@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, lethal@linux-sh.org, akpm@linux-foundation.org

Hi Magnus,

the whole this patch-series has been pulled into the v4l tree now, which 
means there hasn't been any critical issues left, at least none are 
known:-)

A couple of general notes, that would be nice to address in an incremental 
patch:

1. the driver could benefit from a bit more comments:-) At least for 
register configuration.

2. code like

> +	ceu_write(pcdev, CETCR, ~ceu_read(pcdev, CETCR) & 0x0317f313);
> +	ceu_write(pcdev, CEIER, ceu_read(pcdev, CEIER) | 1);
> +
> +	ceu_write(pcdev, CAPCR, ceu_read(pcdev, CAPCR) & ~0x10000);
> +
> +	ceu_write(pcdev, CETCR, 0x0317f313 ^ 0x10);

specifically the 0x0317f313 constants in it might better be coded with 
macros, or at least should be commented.

3. you don't seem to check the interrupt reason nor to handle any error 
conditions like overflow. I guess, there is something like a status 
register on the interface, that you can check on an interrupt to see what 
really was the cause for it.

4. you really managed it to keep the driver platform-neutral!:-) Still, do 
we need an ack from the SH-maintainer? If you think we do, please, try to 
obtain one asap - the patches should be ready to go upstream by Sunday.

5. the memory you are binding with dma_declare_coherent_memory - is it 
some SoC-local SRAM? Is it usably only by the camera interface or also by 
other devices? You might want to request it first like in 
drivers/scsi/NCR_Q720.c to make sure noone else is using it.

Thanks
Guennadi
---
Guennadi Liakhovetski
