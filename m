From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Oct 2010 08:02:46 +0000
Subject: Re: [PATCH] sh: fix uninitialized spinlock
Message-Id: <20101006080246.GC15712@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1286294040-6171-1-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1286294040-6171-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 06, 2010 at 12:54:00AM +0900, Akinobu Mita wrote:
> The spinlock in traps_64.c is used without initialization.
> This fixes it by declaring DEFINE_SPINLOCK() and makes the spinlock static
> variable.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: linux-sh@vger.kernel.org

Hmm, there was a reason why this was non-static before, but it seems like
whatever that was has since corrected itself.  Applied, thanks!
