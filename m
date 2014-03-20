From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 20 Mar 2014 11:59:30 +0000
Subject: Re: [PATCH 0/5] ARM: shmobile: Enable drivers/sh/pm_runtime.c on multi-platform
Message-Id: <8114222.hr4ELyZWaz@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1395256010-12222-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1395256010-12222-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Thursday 20 March 2014 09:56:17 Ben Dooks wrote:
> On 19/03/14 20:06, Geert Uytterhoeven wrote:
> > This patchset enables the PM runtime code in drivers/sh/pm_runtime.c when
> > running a multi-platform ARM kernel including support for shmobile.
> > Before this code was only enabled for legacy shmobile kernels, leading to
> > disabled clocks in multiplatform kernels, depending on implicit reset
> > state or on the bootloader.
> > 
> >    [1/5] drivers: sh: pm_runtime does not need idle callback
> >    [2/5] sh: intc: Restrict INTC_USERIMASK to SH4A
> 
> I thought there was already a of capable intc driver in the
> irq drivers directory?

I think Ben's point is that drivers/sh/intc might be completely unneeded for 
ARM.

> >    [3/5] drivers: sh: compile drivers/sh/pm_runtime.c if
> >    ARCH_SHMOBILE_MULTI
> >    [4/5] ARM: shmobile: Call sh_pm_runtime_init() from platform code on
> >    all
> >    
> >          SoCs
> >    
> >    [5/5] drivers: sh: Remove automatic sh_pm_runtime_init() if
> >    
> >          ARCH_SHMOBILE_LEGACY
> > 
> > Patches 1 and 3 were authored by Ben Dooks, with some changes made by me
> > (for patch 3). Patch 4 was based on a patch by Ben for r8a7790.
> > 
> > After this it should be safe to revert the various commits to "Work around
> > core clock issues". Note that this is just a port of the existing
> > sh(mobile)-specifc PM runtime code from legacy to multi-platform, so
> > expect more work to fix the core issues.
> > 
> > This was tested on Koelsch, both legacy and multi-platform.
> > 
> > Many thanks to Ben Dooks, Laurent Pinchart, and Magnus Damm for the
> > valuable input, investigations, and discussions.
> 
> Thanks, I will probably not get around to testing this until next
> week as I am not in the office until Monday now. I think there is
> one more thing we need to do, which is to do a device suspend and
> resume like the current davinci implementation.

-- 
Regards,

Laurent Pinchart

