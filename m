From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 04 Apr 2011 08:07:58 +0000
Subject: Re: [PATCH 1/2] ARM: mach-shmobile: Correctly check for CONFIG_MACH_MACKEREL
Message-Id: <20110404080757.GB28208@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1301899522-20546-2-git-send-email-horms@verge.net.au>
In-Reply-To: <1301899522-20546-2-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 04, 2011 at 03:45:21PM +0900, Simon Horman wrote:
> I made a bit of a thinko when adding Mackerel to the boards
> that support zboot using MMCIF.
> 
> Reported-by: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

This looks like an obvious fix, I'll queue it up, thanks.
