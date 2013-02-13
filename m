From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Feb 2013 08:41:17 +0000
Subject: Cortex-A15 MM patches
Message-Id: <20130213084117.GA6356@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Catalin, Hi All,

I would like to enquire about the status of two patches which I believe
were part of TC2 Evaluation Build which uses commit
7d80417ef67d51db15d5e72ac336aa6e0586014f of linaro-tracking.git.

  http://releases.linaro.org/12.10/android/vexpress

1. ARM: LPAE: Invalidate the TLB for module addresses during translation fault

   http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/086036.html

2. ARMv7: Do not clean the PTE if coherent page table walk is supported

   http://lists.infradead.org/pipermail/linux-arm-kernel/2011-July/055379.html

As per the links above the patches have been posted upstream some time ago.
In the case of the first patch an alternate approach was discussed.

   http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/086147.html

However, I do not see these changes upstream as of next-20120212.
I am wondering if an alternate approach has been taken upstream
or if these patches are still required upstream.

Thanks
