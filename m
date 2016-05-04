From: Rich Felker <dalias@libc.org>
Date: Wed, 04 May 2016 02:49:41 +0000
Subject: Re: [PATCH RESEND 03/12] sh: Disable board specific code in OF mode
Message-Id: <20160504024941.GN21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <1462079316-27771-1-git-send-email-ysato@users.sourceforge.jp>
 <1462079316-27771-4-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1462079316-27771-4-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, May 01, 2016 at 02:08:27PM +0900, Yoshinori Sato wrote:
> Board specific code conflict on of-generic.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  arch/sh/Makefile | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/sh/Makefile b/arch/sh/Makefile
> index bf5b3f5..8ff943b 100644
> --- a/arch/sh/Makefile
> +++ b/arch/sh/Makefile
> @@ -130,6 +130,9 @@ head-y	:= arch/sh/kernel/head_$(BITS).o
>  core-y				+= arch/sh/kernel/ arch/sh/mm/ arch/sh/boards/
>  core-$(CONFIG_SH_FPU_EMU)	+= arch/sh/math-emu/
>  
> +core-$(CONFIG_USE_BUILTIN_DTB)	+= arch/sh/boot/dts/
> +

It looks like you inadvertently mixed the builtin-dtb patch with this
commit. Is yours based on the builtin-dtb patch I posted to the list
or a different approach?

> +ifneq ($(CONFIG_SH_DEVICE_TREE),y)
>  # Mach groups
>  machdir-$(CONFIG_SOLUTION_ENGINE)		+= mach-se
>  machdir-$(CONFIG_SH_HP6XX)			+= mach-hp6xx
> @@ -150,6 +153,7 @@ machdir-$(CONFIG_SH_LANDISK)			+= mach-landisk
>  machdir-$(CONFIG_SH_LBOX_RE2)			+= mach-lboxre2
>  machdir-$(CONFIG_SH_CAYMAN)			+= mach-cayman
>  machdir-$(CONFIG_SH_RSK)			+= mach-rsk
> +endif

Is this actually necessary? I thought SH_DEVICE_TREE was mutually
exclusive with board-specific configs at the Kconfig level. If not, it
should probably be handled that way rather than with logic like this
in the Makefile.

>  ifneq ($(machdir-y),)
>  core-y	+= $(addprefix arch/sh/boards/, \
> @@ -222,6 +226,13 @@ archclean:
>  	$(Q)$(MAKE) $(clean)=$(boot)
>  	$(Q)$(MAKE) $(clean)=arch/sh/kernel/vsyscall
>  
> +%.dtb %.dtb.S %.dtb.o: | scripts
> +	$(Q)$(MAKE) $(build)=arch/sh/boot/dts arch/sh/boot/dts/$@
> +
> +PHONY += dtbs
> +dtbs: scripts
> +	$(Q)$(MAKE) $(build)=arch/sh/boot/dts
> +
>  define archhelp
>  	@echo '  zImage 	           - Compressed kernel image'
>  	@echo '  romImage	           - Compressed ROM image, if supported'
> -- 

More builtin-dtb stuff.

Rich
