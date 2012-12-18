From: Simon Horman <horms@verge.net.au>
Date: Tue, 18 Dec 2012 02:18:31 +0000
Subject: Re: [PATCH v3 54/81] ARM: shmobile: sh73a0: Use driver-provided pinmux info
Message-Id: <20121218021831.GO28065@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1355611915-25060-55-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1355611915-25060-55-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Dec 15, 2012 at 11:51:28PM +0100, Laurent Pinchart wrote:
> Pinmux info for the sh73a0 is now provided by pinmux drivers. Remove the
> duplicate copy in arch code.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/mach-shmobile/Makefile       |    5 -
>  arch/arm/mach-shmobile/pfc-sh73a0.c   | 2829 ---------------------------------
>  arch/arm/mach-shmobile/setup-sh73a0.c |   25 +
>  3 files changed, 25 insertions(+), 2834 deletions(-)
>  delete mode 100644 arch/arm/mach-shmobile/pfc-sh73a0.c

Acked-by: Simon Horman <horms+renesas@verge.net.au>

