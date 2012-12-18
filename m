From: Simon Horman <horms@verge.net.au>
Date: Tue, 18 Dec 2012 02:18:14 +0000
Subject: Re: [PATCH v3 53/81] ARM: shmobile: sh7372: Use driver-provided pinmux info
Message-Id: <20121218021814.GN28065@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1355611915-25060-54-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1355611915-25060-54-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Dec 15, 2012 at 11:51:27PM +0100, Laurent Pinchart wrote:
> Pinmux info for the sh7372 is now provided by pinmux drivers. Remove the
> duplicate copy in arch code.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/mach-shmobile/Makefile       |    1 -
>  arch/arm/mach-shmobile/pfc-sh7372.c   | 1689 ---------------------------------
>  arch/arm/mach-shmobile/setup-sh7372.c |   26 +
>  3 files changed, 26 insertions(+), 1690 deletions(-)
>  delete mode 100644 arch/arm/mach-shmobile/pfc-sh7372.c

Acked-by: Simon Horman <horms+renesas@verge.net.au>

