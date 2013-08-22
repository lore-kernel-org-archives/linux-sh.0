From: Simon Horman <horms@verge.net.au>
Date: Thu, 22 Aug 2013 06:27:16 +0000
Subject: Re: [PATCH v3 7/8] ARM: shmobile: lager: Add Display Unit support
Message-Id: <20130822062716.GO11086@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1375963414-31096-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375963414-31096-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 08, 2013 at 02:03:33PM +0200, Laurent Pinchart wrote:
> Only the VGA output is currently supported.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/mach-shmobile/board-lager.c | 67 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)

Thanks, I have merged this into the boards3 branch which includes a merge
of git://people.freedesktop.Org/~airlied/linux drm-rcar-for-v3.12
