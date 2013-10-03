From: Simon Horman <horms@verge.net.au>
Date: Thu, 03 Oct 2013 04:22:57 +0000
Subject: Re: [PATCH 02/05] ARM: shmobile: Use KZM9D without reference for multiplatform
Message-Id: <20131003042255.GN7925@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131001103255.813.65710.sendpatchset@w520>
 <20131001103315.813.80581.sendpatchset@w520>
In-Reply-To: <20131001103315.813.80581.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Oct 01, 2013 at 07:33:15PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Change the multiplatform kconfig bits for KZM9D from
> CONFIG_MACH_KZM9D_REFERENCE into CONFIG_MACH_KZM9D
> to match the non-multiplatform case.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/Kconfig  |   10 ++--------
>  arch/arm/mach-shmobile/Makefile |    4 ++++
>  2 files changed, 6 insertions(+), 8 deletions(-)

Thanks, I have queued this up in the boards3 branch.
It should make it into v3.13 but if not I'll rename the branch
soc after rebasing it on v3.13-rcX which will then be targeted at v3.14.
