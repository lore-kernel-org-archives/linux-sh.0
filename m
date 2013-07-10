From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Jul 2013 01:23:47 +0000
Subject: Re: [PATCH 00/02] ARM: shmobile: r8a7790 arch timer frequency update
Message-Id: <20130710012346.GT32603@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130709125007.4388.15701.sendpatchset@w520>
In-Reply-To: <20130709125007.4388.15701.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jul 09, 2013 at 09:50:07PM +0900, Magnus Damm wrote:
> ARM: shmobile: r8a7790 arch timer frequency update
> 
> [PATCH 01/02] ARM: shmobile: Introduce r8a7790_read_mode_pins()
> [PATCH 02/02] ARM: shmobile: Setup r8a7790 arch timer based on MD pins
> 
> Add code to setup r8a7790 arch timer frequency dynamically at boot time
> based on the EXTAL frequency pointed out by the boot mode pins.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Built on top of renesas-next-20130704v2
> 
>  arch/arm/mach-shmobile/clock-r8a7790.c        |   11 ----
>  arch/arm/mach-shmobile/include/mach/r8a7790.h |    3 +
>  arch/arm/mach-shmobile/setup-r8a7790.c        |   63 +++++++++++++++++++++++--
>  3 files changed, 63 insertions(+), 14 deletions(-)

Hi Magnus,

could you please let me know if/when these patches are ready to queue-up
for v3.12?
