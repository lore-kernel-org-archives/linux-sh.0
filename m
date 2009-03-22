From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sun, 22 Mar 2009 11:49:36 +0000
Subject: Re: Kernel fails on Dreamcast - results of bisection
Message-Id: <1237722576.6534.3.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1237675045.27611.23.camel@localhost.localdomain>
In-Reply-To: <1237675045.27611.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, 2009-03-22 at 20:01 +0900, Paul Mundt wrote:

> Please test with it reverted and with no changes to the defconfig. If you
> are randomly going to change variables, then the bug report is
> speculation at best. If you are going to make config changes at the same
> time that you revert changes, you are not debugging the problem at hand.
> It is not even worth looking at this until you are sure the same scenario
> exists without config changes.
> --


I used the same configuration throughout the bisection. So there is a
real bug there. There is no speculation involved. Builds before a
certain point will boot, builds after do not. And the patch that breaks
the kernel is the one I have identified.

