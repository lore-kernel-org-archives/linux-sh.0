From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 01 Feb 2012 05:42:21 +0000
Subject: Re: [PULL] ARM mach/irqs.h cleanup for 3.4
Message-Id: <20120201054221.GA3531@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F284532.90303@gmail.com>
In-Reply-To: <4F284532.90303@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jan 31, 2012 at 01:46:58PM -0600, Rob Herring wrote:
> Can you please pull mach/irqs.h clean-up for 3.4. I've gotten little to
> no response from the affected platform maintainers. It's primarily
> superh and shmobile that have any significant changes though.
> 
Sorry about that, it's been in my backlog. The changes as they are are
fine with me, I've got some pending work that switches to dynamic use off
of nr_irqs that will make most of it redundant that I had hoped to have
done in time, but it can be done incrementally at a later point in time,
too.
