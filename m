From: Simon Horman <horms@verge.net.au>
Date: Tue, 18 Dec 2012 02:18:03 +0000
Subject: Re: [PATCH v3 51/81] ARM: shmobile: r8a7740: Use driver-provided pinmux info
Message-Id: <20121218021803.GM28065@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1355611915-25060-52-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1355611915-25060-52-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Dec 15, 2012 at 11:51:25PM +0100, Laurent Pinchart wrote:
> Pinmux info for the r8a7740 is now provided by pinmux drivers. Remove
> the duplicate copy in arch code.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/mach-shmobile/Makefile        |    1 -
>  arch/arm/mach-shmobile/pfc-r8a7740.c   | 2643 --------------------------------
>  arch/arm/mach-shmobile/setup-r8a7740.c |   26 +
>  3 files changed, 26 insertions(+), 2644 deletions(-)
>  delete mode 100644 arch/arm/mach-shmobile/pfc-r8a7740.c

Code reduction, excellent!

Acked-by: Simon Horman <horms+renesas@verge.net.au>
