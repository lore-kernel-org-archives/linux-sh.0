From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Jun 2013 14:09:37 +0000
Subject: Re: [PATCH 01/06] ARM: shmobile: Add SMP boot function and argument
Message-Id: <20130612140936.GR32751@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130610091925.18944.68117.sendpatchset@w520>
 <20130610091936.18944.66463.sendpatchset@w520>
In-Reply-To: <20130610091936.18944.66463.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 10, 2013 at 06:19:36PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add code for mach-shmobile to allow specifying boot function
> and argument. Will initially be used for SMP together with SCU
> but may in the future also be used for deep sleep resume. This
> patch removes one inline virtual to physical address conversion.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/headsmp.S             |   13 ++++++++++---
>  arch/arm/mach-shmobile/include/mach/common.h |    4 +++-
>  2 files changed, 13 insertions(+), 4 deletions(-)

Thanks, I have queued this up for v3.11 in the (new) cleanup-boot branch.
