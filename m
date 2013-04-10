From: Bastian Hecht <hechtb@gmail.com>
Date: Wed, 10 Apr 2013 10:43:13 +0000
Subject: v7_flush_kern_cache_louis flushes up to L2?
Message-Id: <CABYn4sxUCoWhC_4qydzbCtZdQdetqFZ_u5WtXsghprQget9f5g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

I've got a Cortex-A9 UP with a L2 and want to submit some PM code I've
written. Just to make sure I've made no mistake, it would be very
helpful if you can confirm a hypothesis I use in my code:

v7_flush_kern_cache_louis: Flush the data cache up to Level of
Unification Inner Shareable

This flushes the data out up to the L2, right? The ARM docs say that
the Point of Unification would be my L2. I'm a bit confused by the
term "Level of Unification Inner Shareable" (that states that in an
SMP system L1 coherency is guaranteed and all is flushed to the L2?).

Thanks,

 Bastian
