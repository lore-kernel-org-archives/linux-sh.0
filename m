From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 18 Jul 2008 22:27:13 +0000
Subject: Re: [PATCH 05/06] sh_mobile_ceu_camera: Add SuperH Mobile CEU driver V3
Message-Id: <20080718222713.GA18822@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080714120249.4806.66136.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080714120249.4806.66136.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Jul 19, 2008 at 12:14:42AM +0200, Guennadi Liakhovetski wrote:
> On Sat, 19 Jul 2008, Paul Mundt wrote:
> 
> > On Fri, Jul 18, 2008 at 10:23:14AM +0200, Guennadi Liakhovetski wrote:
> > > On Fri, 18 Jul 2008, Magnus Damm wrote:
> > > > Regarding request_mem_region() - I used to add that here and there,
> > > > but I think the platform driver layer should handle that for us
> > > > automatically these days. I'm not 100% sure though. =)
> > > 
> > > I had a short look and didn't find anything like that there... So, you 
> > > might want to double-check and add if needed.
> > > 
> > It's a bit obscured, but it's certainly handled generically these days.
> > 
> > Look at drivers/base/platform.c:platform_device_add(). The resource type
> > is checked there and handed off to insert_resource().
> > platform_device_add() is likewise wrapped in to from
> > platform_device_register(), so everyone claims the resources
> > unconditionally.
> 
> Sorry, I still don't qite follow. _Resources_ get accounted with the 
> platform_device_add() / platform_device_del(), and are searched by 
> platform_get_resource(), but even this doesn't lock the resource like 
> some other "get" methods. I can see that. But we are talking not about 
> "struct resource" accounting, but about memory regions. And I don't see 
> this done anywhere in platform-device / resource handling.

Uhm, what? What do you think request_mem_region() does? It most certainly
is about struct resource accounting, and the use of insert_resource() is
very clearly documented in kernel/resource.c.

If you have an IORESOURCE_MEM resource in your platform device, the
iomem_resource pointer gets referenced, just as with
request_mem_region(), and they both go through __request_region(). The
only difference is that request_mem_region() doesn't permit nesting,
while insert_resource() does. There's nothing else going on here.

platform_get_resource() has nothing to do with platform_device_add()
setting up resources, it's just a helper to find a struct resource by its
IORESOURCE type nested in the platform device, as they are very often out
of order. platform_get_irq() tends to be the most useful of these.
