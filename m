From: Simon Horman <horms@verge.net.au>
Date: Tue, 12 Nov 2013 05:11:37 +0000
Subject: Re: [PATCH 1/2] ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY
Message-Id: <20131112051137.GB28649@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1384000429-3590-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1384000429-3590-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384000429-3590-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org

On Sat, Nov 09, 2013 at 01:33:48PM +0100, Laurent Pinchart wrote:
> SH-Mobile platforms are transitioning from non-multiplatform to
> multiplatform kernel. A new ARCH_SHMOBILE_MULTI configuration symbol has
> been created to group all multiplatform-enabled SH-Mobile SoCs. The
> existing ARCH_SHMOBILE configuration symbol groups SoCs that haven't
> been converted yet.
> 
> This arrangement works fine for the arch/ code, but lots of drivers
> needed on both ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI depend on
> ARCH_SHMOBILE only. In order to avoid changing them, rename
> ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY, and create a new boolean
> ARCH_SHMOBILE configuration symbol that is selected by both
> ARCH_SHMOBILE_LEGACY and ARCH_SHMOBILE_MULTI.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up.
