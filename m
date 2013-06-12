From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Jun 2013 14:09:56 +0000
Subject: Re: [PATCH 05/06] ARM: shmobile: EMEV2 SMP with SCU boot fn and args
Message-Id: <20130612140955.GV32751@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130610091925.18944.68117.sendpatchset@w520>
 <20130610092015.18944.61634.sendpatchset@w520>
In-Reply-To: <20130610092015.18944.61634.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 10, 2013 at 06:20:15PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Let EMEV2 make use of shmobile_boot_fn and shmobile_boot_arg
> together with shmobile_boot_scu and the SCU base address.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/smp-emev2.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Thanks, I have queued this up for v3.11 in the (new) cleanup-boot branch.
