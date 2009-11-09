From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 09 Nov 2009 01:49:03 +0000
Subject: Re: [patch 13/16] sh: Replace old style lock initializer
Message-Id: <20091109014903.GA14254@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091106223547.784916750@linutronix.de> <20091106223806.933145642@linutronix.de>
In-Reply-To: <20091106223806.933145642@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, linux-sh@vger.kernel.org

On Fri, Nov 06, 2009 at 10:42:05PM -0000, Thomas Gleixner wrote:
> SPIN_LOCK_UNLOCKED is deprecated. Use __SPIN_LOCK_UNLOCKED instead.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: linux-sh@vger.kernel.org

Applied, thanks.
