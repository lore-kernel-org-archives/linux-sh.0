From: Simon Horman <horms@verge.net.au>
Date: Wed, 24 Jul 2013 08:07:12 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a73a4: Remove ->init_machine() special case
Message-Id: <20130724080711.GM10027@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130724035315.30631.28824.sendpatchset@w520>
In-Reply-To: <20130724035315.30631.28824.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, g.liakhovetski@gmx.de, linux-sh@vger.kernel.org

On Wed, Jul 24, 2013 at 12:53:15PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> No need to special case r8a73a4 ->init_machine(),
> so get rid of undesired cpufreq platform device
> from the generic long term r8a73a4 DT support code.
> 
> For short term support on APE6EVM the DT reference
> implementation already adds a "cpufreq-cpu0" platform
> device so that can be used for development.
> 
> Regarding more long term cpufreq support, perhaps
> it makes sense to adjust the cpufreq driver to check
> for DT information directly instead of using a
> platform device for software configuration and DT
> for hardware parameters.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/setup-r8a73a4.c |    6 ------
>  1 file changed, 6 deletions(-)

Thanks, I have queued this up for v3.12 in the cleanup2 branch.
