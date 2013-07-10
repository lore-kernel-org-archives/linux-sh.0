From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Jul 2013 13:20:59 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: Force ARM mode to compile reset vector for secondary CPUs
Message-Id: <20130710132059.GC13716@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1373421397-1786-1-git-send-email-koba@kmckk.co.jp>
 <1373421397-1786-3-git-send-email-koba@kmckk.co.jp>
In-Reply-To: <1373421397-1786-3-git-send-email-koba@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jul 10, 2013 at 10:56:36AM +0900, Tetsuyuki Kobayashi wrote:
> Instructions start from boot vector must be ARM mode.
> This patch specify ARM mode explicitly and use 'bx' instruction to be
> able to change to Thumb mode.
> 
> Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> ---
>  arch/arm/mach-shmobile/headsmp.S |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Thanks, I have queued this up with Magnus's ack in the thumb-fixes
branch of my renesas tree on kernel.org. It should be
included in the renesas-next-20130710v2 tag.
