From: Simon Horman <horms@verge.net.au>
Date: Thu, 01 Aug 2013 07:23:18 +0000
Subject: Re: [PATCH v6 0/3] ARM: shmobile: lager: enable Ether
Message-Id: <20130801072318.GA26015@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1375175361-23027-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1375175361-23027-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jul 30, 2013 at 06:09:18PM +0900, Simon Horman wrote:
> this short series enables the on-board ethernet
> of the r8a7790 SoC for on lager board.
> 
> It has a run-time dependency on
> "sh_eth: add support for r8a7790 SoC"
> 
> It has been built on top of renesas-next-20130726.
> 
> Changes noted in changelogs of individual patches.
> 
> Simon Horman (3):
>   ARM: shmobile: r8a7790: clocks for Ether support
>   ARM: shmobile: lager: enable Ether
>   ARM: shmobile: lager: enable nfsroot in DTS
> 
>  arch/arm/boot/dts/r8a7790-lager.dts    |  2 +-
>  arch/arm/mach-shmobile/board-lager.c   | 30 ++++++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/clock-r8a7790.c |  4 ++++
>  3 files changed, 35 insertions(+), 1 deletion(-)

Hi Magnus, Hi all,

I would appreciate some review of this, and if appropriate an Ack.
