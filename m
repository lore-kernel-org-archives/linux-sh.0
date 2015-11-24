From: Simon Horman <horms@verge.net.au>
Date: Tue, 24 Nov 2015 02:39:46 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: r8a7790: switch console back to scif0
Message-Id: <20151124023945.GB21853@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1447431743-16376-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1447431743-16376-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 13, 2015 at 05:22:23PM +0100, Ulrich Hecht wrote:
> The boot loader uses scif0, and so must we if we want earlycon to work.
> 
> Partially reverts 7c0558941 ("ARM: shmobile: r8a7790: switch from scif
> to scifa").
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Thanks, I have queued this up for v4.5.
