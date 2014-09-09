From: Simon Horman <horms@verge.net.au>
Date: Tue, 09 Sep 2014 02:21:10 +0000
Subject: Re: [PATCH 0/5] ARM: shmobile: pm domain improvements and cleanups
Message-Id: <20140909022109.GB31320@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 29, 2014 at 03:26:17PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series improves and cleans up the initialization of power domains
> and their devices on sh7372/mackerel and r8a7740/armadillo800eva.

Thanks, I have queued these up.

As I have (once again) received push-back from the ARM-SoC maintainers
relating to cleanups I will describe my reasoning for picking these up
below.

I have picked these up because they can be applied cleanly on
top of v3.17-rc1 and do not conflict with anything else that is
currently queued up for v3.18. As such I do not believe I need
to consider deferring them until v3.19.

If, on the other hand, they had conflicted with patches queued up
for v3.18 I would have been hesitant to pick them up and probably
would have asked you to defer them until v3.19. This is because
within a release cycle the ARM-SoC maintainers have a preference for
cleanups to come before other changes.

I hope the above makes sense and may help everyone to understand
a little more how I am handling cleanups in accordance with request
made by the ARM-SoC maintainers.
