From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 18 Jul 2008 21:46:44 +0000
Subject: Re: [PATCH 05/06] sh_mobile_ceu_camera: Add SuperH Mobile CEU driver V3
Message-Id: <20080718214644.GB21846@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080714120249.4806.66136.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080714120249.4806.66136.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 18, 2008 at 10:23:14AM +0200, Guennadi Liakhovetski wrote:
> On Fri, 18 Jul 2008, Magnus Damm wrote:
> > Regarding request_mem_region() - I used to add that here and there,
> > but I think the platform driver layer should handle that for us
> > automatically these days. I'm not 100% sure though. =)
> 
> I had a short look and didn't find anything like that there... So, you 
> might want to double-check and add if needed.
> 
It's a bit obscured, but it's certainly handled generically these days.

Look at drivers/base/platform.c:platform_device_add(). The resource type
is checked there and handed off to insert_resource().
platform_device_add() is likewise wrapped in to from
platform_device_register(), so everyone claims the resources
unconditionally.
