From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Feb 2015 23:31:28 +0000
Subject: Re: [PATCH v2] ARM: shmobile: r8a7790: Fix HSUSB clock to hp_clk from mp_clk
Message-Id: <20150225233128.GH23723@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1424360575-6482-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1424360575-6482-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Feb 19, 2015 at 10:42:55AM -0500, Simon Horman wrote:
> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> 
> HSUSB uses hp_clk rather than mp_clk for H/W register access.
> 
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> [horms: updated changelog]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I have queued this up.
