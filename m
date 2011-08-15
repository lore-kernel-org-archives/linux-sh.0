From: Peter =?iso-8859-2?q?H=FCwe?= <PeterHuewe@gmx.de>
Date: Mon, 15 Aug 2011 14:30:11 +0000
Subject: Re: [PATCH] shmobile/sh7372: Add missing CONFIG_PM guards to fix build failure
Message-Id: <201108151630.12120.PeterHuewe@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1313274841-8322-1-git-send-email-peterhuewe@gmx.de>
	<201108140155.05625.rjw@sisk.pl>
In-Reply-To: <201108140155.05625.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Am Sonntag 14 August 2011, 01:55:05 schrieb Rafael J. Wysocki:
> On Sunday, August 14, 2011, Peter Huewe wrote:
> > This patch fixes a build failure with the ap4evb_defconfig by adding the
> > missing #ifdef CONFIG_PM.
> 
> This is not the right fix.  Besides, you seem to be testing linux-next
> and the build problem is in the linux-pm tree.
> 
> Please check if the appended patch fixes the problem for you.
> 
> Rafael
Works for me - compiles ;)

Reviewed-by: Peter Huewe <peterhuewe@gmx.de>

