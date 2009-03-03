From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 03 Mar 2009 06:44:39 +0000
Subject: Re: [PATCH 6/6] timer-tmu: Add SH7786 support
Message-Id: <20090303064439.GB30177@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 20, 2009 at 04:27:19PM +0900, Kuninori Morimoto wrote:
> L2 cache doesn't support now.
> This only support main cpu though sh7786 is multi core CPU.
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

I've applied this series with a bit of tidying, but have done so as a
single changeset. If you wish to have this applied incrementally as a
series, each one of these patches need to build on the previous ones
incrementally, and no single patch should leave the tree in a broken
state. Splitting them up arbitrarily is not sufficient, as this breaks
bisection, which is not acceptable.

Please keep this in mind for future patches.

> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 78a01d7..0ae0968 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -356,6 +356,13 @@ config CPU_SUBTYPE_SH7785
>  	select ARCH_SPARSEMEM_ENABLE
>  	select SYS_SUPPORTS_NUMA
>  
> +config CPU_SUBTYPE_SH7786
> +	bool "Support SH7786 processor"
> +	select CPU_SH4A
> +	select CPU_SHX2
> +	select ARCH_SPARSEMEM_ENABLE
> +	select SYS_SUPPORTS_NUMA
> +
>  config CPU_SUBTYPE_SHX3
>  	bool "Support SH-X3 processor"
>  	select CPU_SH4A

This is most definitely not an SH-X2 core, so this needs to be selecting
CPU_SHX3 instead. I'll take care of fixing that up though, since some of
the existing SH-X3 code really only applies to the SH-X3 proto CPUs, and
not to SH7786.
