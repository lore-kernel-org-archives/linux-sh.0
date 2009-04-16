From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 16 Apr 2009 05:23:41 +0000
Subject: Re: [PATCH 05/05] sh: Let SH_TIMER_CMT select GENERIC_TIME
Message-Id: <20090416052341.GB26667@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090415105038.29940.67915.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090415105038.29940.67915.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 15, 2009 at 07:50:38PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Let SH_TIMER_CMT select GENERIC_TIME. This since GENERIC_TIME is
> required to build the CMT driver. Without this patch the TMU driver
> must be enabled for the CMT driver to build.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  arch/sh/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- 0001/arch/sh/Kconfig
> +++ work/arch/sh/Kconfig	2009-02-04 19:29:12.000000000 +0900
> @@ -431,6 +431,7 @@ config SH_CMT
>  config SH_TIMER_CMT
>  	bool "CMT clockevents driver"
>  	depends on SYS_SUPPORTS_CMT && !SH_CMT
> +	select GENERIC_TIME
>  	select GENERIC_CLOCKEVENTS
>  
We can't do this yet, as the mtu2 sys_timer code is not GENERIC_TIME
ready. So if one uses that in conjunction with SH_TIMER_CMT, it will blow
up. Once the early platform stuff is merged and we can use the new CMT
code for jiffies, then I will change the Kconfig bits around to prevent
any sys_timer drivers being enabled, and at that point this can be
applied.
