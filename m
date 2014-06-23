From: Simon Horman <horms@verge.net.au>
Date: Mon, 23 Jun 2014 00:54:35 +0000
Subject: Re: [PATCH] ARM: shmobile: Remove ARCH_HAS_CPUFREQ config for shmobile
Message-Id: <20140623005435.GB8798@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <53A2C420.3080609@bp.renesas.com>
In-Reply-To: <53A2C420.3080609@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 19, 2014 at 08:06:08PM +0900, Gaku Inami wrote:
> The following commit has removed ARCH_HAS_CPUFREQ config:
> 
>  Commit: e49d9b375628e67c9a718f4befaa8e45e5fad21b
>  Subject: ARM: Remove ARCH_HAS_CPUFREQ config option
> 
> This patch removes the code that is using ARCH_HAS_CPUFREQ
> in mach-shmobile.

Thanks, I will queue this up.
