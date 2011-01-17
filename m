From: Jeremy Kerr <jk@ozlabs.org>
Date: Mon, 17 Jan 2011 01:19:44 +0000
Subject: Re: Locking in the clk API
Message-Id: <201101170919.45100.jk@ozlabs.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
In-Reply-To: <201101111016.42819.jeremy.kerr@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi all,

Based on the discussion from this thread, my plan is to:

* Change the 'common struct clk' patches to only use a spinlock for locking. 
This means that clk_{en,dis}able will acquire a per-clk spinlock (for enable 
counts), and be callable from atomic contexts.

* Rework the initial docs (posted in the first mail of this thread) document 
to illustrate the new locking requirements.

* Request input from the platforms that require clk_enable (etc) to sleep, 
about how we can merge the two implementations.

Russell - is this OK?

Cheers,


Jeremy
