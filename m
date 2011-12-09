From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 09 Dec 2011 08:56:17 +0000
Subject: Re: [PATCH 04/04] sh: use ioread32/iowrite32 and mapped_reg for div6
Message-Id: <20111209085617.GB19960@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20111208135922.18394.95163.sendpatchset@w520>
In-Reply-To: <20111208135922.18394.95163.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 08, 2011 at 09:49:46PM -0800, Kuninori Morimoto wrote:
> I tested these patch set on mackerel board with linus/master.
> it works well.
> 
> But I'm afraid that this div6 patch didn't care
> paul/common/clkfwk which has below commit.
> it is still using clk->enable_reg.
> 
> Of course I can modify it after merge ;)
> 
That's ok, it's trivial to fix, I'll just tidy it up by hand when
merging. I'll add your Tested-by.
