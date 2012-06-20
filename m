From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 12:18:31 +0000
Subject: Re: [PATCH 01/11] ARM: mach-shmobile: add a temporary macro to define fixed voltage regulators
Message-Id: <Pine.LNX.4.64.1206201408000.20254@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1340179300-16452-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1340179300-16452-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 20 Jun 2012, Mark Brown wrote:

> On Wed, Jun 20, 2012 at 10:01:30AM +0200, Guennadi Liakhovetski wrote:
> > Providing fixed voltage permanently "on" regulators with different voltages
> > shares a lot of identical code. It will be eliminated, once the
> > regulator_register_fixed_volt() function becomes available. Until then we
> > introduce a macro to define such regulators. This helps reduce the amount
> > of added code in each platform file and keeps copy-paste errors to the
> > minumum.
> 
> Or you could just pull in the topic branch I created for the purpose of
> allowing other trees to pick this up:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/topic/fixed
> 
> which should save everyone work all round.  Just don't rebase.

Thanks, Mark! Yes, maybe we'll do that. I'd submit a v2 shortly then. It 
should be relatively simple to switch to using that macro - I'd just have 
to replace these two lines:

+REGULATOR_FIXED(fixed3v3_power_consumers, 0, 3300000);
...
+	&fixed_power_0,

with something like this

+	regulator_register_always_on(0, "Fixed #0", fixed3v3_power_consumers, 
+				ARRAY_SIZE(fixed3v3_power_consumers), 3300000);

The idea behind that macro is to be able to merge these two series 
independently via their respective trees. I'll be shortly sending one more 
similar patch series for the sh arch, using an identical macro. If it is 
decided to pull in my regulator core patches, I'll rebase that one too.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
