From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 05 Feb 2013 03:30:41 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779: Correct TMU clock support
Message-Id: <CANqRtoQnt3WEm1XDOeoMy9wxfPVH47Wp+J9MFh3mReXoW+h11Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1360034939-32082-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1360034939-32082-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hey Simon,

On Tue, Feb 5, 2013 at 12:28 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> During code review it was noticed that the clock value for
> TMU01 was incorrect and the value for TMU02 was missing.
>
> For reference: As of 3.8-rc6 there are no in-tree consumes of these clocks.
>
> Reported-by: Denis Oliver Kropp <dok@directfb.org>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Looking good, thanks for fixing.

Reviewed-by: Magnus Damm <damm@opensource.se>

/ magnus
