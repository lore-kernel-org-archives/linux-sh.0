From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 19 May 2012 06:11:40 +0000
Subject: [PATCH 0/8] irqdomain cleanups + identity mapping support
Message-Id: <1337407908-7421-1-git-send-email-lethal@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Here's the current patch stack I've got against the irqdomain code, which
is about what I need to start being able to reasonably start converting
the SH INTC subsystem over to it.

This whole series is also available via git at:

	git://github.com/pmundt/linux-sh.git common/irqdomain

but I've not yet created a signed tag to pull from as there's likely
still a fair bit of work to do. The diffstat looks innocuous enough, but
is obviously of no real value in this case:

Paul Mundt (8):
      irqdomain: Support removal of IRQ domains.
      irqdomain: Export remaining public API symbols.
      irqdomain: Make irq_domain_simple_map() static.
      irqdomain: Simple NUMA awareness.
      irqdomain: Kill off duplicate definitions.
      irqdomain: Support identity mapped VIRQ allocation.
      irqdomain: trivial pr_fmt conversion.
      irqdomain: Support insertion of existing IRQ allocations.

 include/linux/irqdomain.h |   12 +-
 include/linux/of.h        |   10 +-
 kernel/irq/irqdomain.c    |  187 ++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 168 insertions(+), 41 deletions(-)

