From: Simon Horman <horms@verge.net.au>
Date: Fri, 02 Oct 2015 01:57:13 +0000
Subject: Re: [PATCH 13/38] ARM: shmobile: apmu: correct type of CPU id
Message-Id: <20151002015713.GA7043@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
 <1442842450-29769-14-git-send-email-a.hajda@samsung.com>
In-Reply-To: <1442842450-29769-14-git-send-email-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Sep 21, 2015 at 03:33:45PM +0200, Andrzej Hajda wrote:
> CPU id can be negative, so it cannot be assigned to unsigned variable.
> 
> The problem has been detected using proposed semantic patch
> scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].
> 
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2038576
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>

Thanks, I have queued this up as a cleanup for v4.4.
