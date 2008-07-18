From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 18 Jul 2008 22:48:08 +0000
Subject: Re: [PATCH 05/06] sh_mobile_ceu_camera: Add SuperH Mobile CEU driver
Message-Id: <Pine.LNX.4.64.0807190046260.32334@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20080714120204.4806.87287.sendpatchset@rx1.opensource.se>
	<20080714120249.4806.66136.sendpatchset@rx1.opensource.se>
	<Pine.LNX.4.64.0807180918160.13569@axis700.grange>
	<aec7e5c30807180107g6d2f55fdh917da10963f3df20@mail.gmail.com>
	<Pine.LNX.4.64.0807181015470.14224@axis700.grange>
	<20080718214644.GB21846@linux-sh.org>
	<Pine.LNX.4.64.0807190009550.32334@axis700.grange>
	<20080718222713.GA18822@linux-sh.org>
In-Reply-To: <20080718222713.GA18822@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: video4linux-list@redhat.com, linux-sh@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, paulius.zaleckas@teltonika.lt, akpm@linux-foundation.org

On Sat, 19 Jul 2008, Paul Mundt wrote:

> If you have an IORESOURCE_MEM resource in your platform device, the
> iomem_resource pointer gets referenced, just as with
> request_mem_region(), and they both go through __request_region(). The
> only difference is that request_mem_region() doesn't permit nesting,
> while insert_resource() does. There's nothing else going on here.

Indeed, I was so used to request_mem_region() that I didn't think about it 
in terms of "struct resource" management. I stand corrected.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
