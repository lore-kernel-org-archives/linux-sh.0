From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 08 Dec 2008 07:59:47 +0000
Subject: Re: [Bug report] dead lock is occur in mutex_trylock
Message-Id: <20081208075946.GB14767@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uej0jyw3m.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uej0jyw3m.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 08, 2008 at 04:53:53PM +0900, morimoto.kuninori@renesas.com wrote:
> 
> Dear Paul
> 
> > > It works well if I use old ${LINUX}/arch/sh/include/asm/mutex-llsc.h,
> > > But, latest mutex-llsc.h seems cause dead lock on __mutex_fastpath_trylock.
> > > 
> > > It confirmed on AP325 board.
> > > 
> > Do you have a test case that can reproduce this?
> 
> I'm using latest linux-sh git and normal AP325 defconfig.
> you can get dead lock when kernel starts MTD setting.
> 
It helps if I'm using the right configuration, whoops.

This ought to do it..

---

diff --git a/arch/sh/include/asm/mutex-llsc.h b/arch/sh/include/asm/mutex-llsc.h
index a91990c..ee839ee 100644
--- a/arch/sh/include/asm/mutex-llsc.h
+++ b/arch/sh/include/asm/mutex-llsc.h
@@ -73,7 +73,7 @@ __mutex_fastpath_unlock(atomic_t *count, void (*fail_fn)(atomic_t *))
 		: "t");
 
 	__res |= !__ex_flag;
-	if (unlikely(__res != 0))
+	if (unlikely(__res <= 0))
 		fail_fn(count);
 }
 
