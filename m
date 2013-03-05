From: Simon Horman <horms@verge.net.au>
Date: Tue, 05 Mar 2013 05:57:00 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: armadillo800eva: enable all errata for cache on defconfig
Message-Id: <20130305055659.GC9711@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1346808893-14124-2-git-send-email-horms@verge.net.au>
In-Reply-To: <1346808893-14124-2-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Mar 03, 2013 at 04:42:08PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > > > > Some errata for cache had not enabled on current
> > > > > > Armadillo800eva defconfig.
> > > > > > This patch enables these.
> > > > > > Special thanks to Ishiyama-san
> > > > > 
> > > > > It seems to me that it would be better to handle these in Kconfig
> > > > > to enable them on an SoC or board basis.
> > > > > 
> > > > > The reason is that I would like to move away from per-board defconfigs
> > > > > and towards a more consolidated defconfig. And in that case it will
> > > > > be more difficult to know which ERRATA are needed for each board and SoC.
> > > > > 
> > > > > Obviously this thinking is open to review and it implies that
> > > > > several board defconfigs should be updated.
> > > 
> > > We used defconfig selection for CPU/board settings before.
> > > But Kconfig selection for ERRATA make sense.
> > > 
> > > Do you want to me to send v2 patch which use Kconfig ?
> > > Or do you do that ?
> > 
> > I'd like you to send v2 if possible.
> 
> OK, but I noticed that it will be complex if we select these ERRATA on Kconfig,
> Because, these ERRATAs dependency.

Thanks, I see this is indeed getting messy.

The reason that I asked is that I would like to consolidate the defconfigs.
Ideally one for shmobile. But more realistically one per SoC. And I thought
that avoiding adding ERRATAs to defconfigs would make that slightly easier
in the long run. But I don't think it justifies dealing with the mess
you describe below. So I will apply the patch as is.

> Ex)
> config PL310_ERRATA_588369
> 	bool "PL310 errata: Clean & Invalidate maintenance operations do not invalidate clean lines"
> 	depends on CACHE_L2X0
> 
> It depends on CACHE_L2X0, but this CACHE_L2X0 selection is depend on user,
> this means that there is no guarantee that CACHE_L2X0 is selected.
> Then, the Kconfig will be...
> 
>         select PL310_ERRATA_588369 if CACHE_L2X0
> 
> And more complex ERRARA dependency is...
> 
> config ARM_ERRATA_742230
> 	bool "ARM errata: DMB operation may be faulty"
> 	depends on CPU_V7 && SMP
> 	depends on !ARCH_MULTIPLATFORM
> 
> Of course I can use above style on Kconfig,
> but my worry is we will have unknown trouble
> if someone updated these ERRATA implementation and dependency
> in the future...
> 
> This is example, but I tested below.
> This means we can select unnecessary settings on Kconfig ...
> 
> ----------------
> config ARM_ERRATA_326103
> 	bool "ARM errata: FSR write bit incorrect on a SWP to read-only memory"
> =>	depends on CPU_V6
>         ...
> 
> config ARCH_R8A7740
> 	bool "R-Mobile A1 (R8A77400)"
> 	select ARCH_WANT_OPTIONAL_GPIOLIB
> =>	select CPU_V7
> =>	select ARM_ERRATA_326103
>         ...
> 
> > grep ERRATA .config
> CONFIG_ARM_ERRATA_326103=y
> ----------------------
> 
> Best regards
> ---
> Kuninori Morimoto
> 
