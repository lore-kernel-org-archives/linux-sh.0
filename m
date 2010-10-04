From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 04 Oct 2010 19:46:59 +0000
Subject: Re: [PATCH V3] arm & sh: factorised duplicated clkdev.c
Message-Id: <20101004194659.GC25241@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
	<20100909095347.GA9112@game.jcrosoft.org>
In-Reply-To: <20100909095347.GA9112@game.jcrosoft.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Sep 09, 2010 at 11:53:47AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 15:39 Thu 02 Sep     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> > factorise some generic infrastructure to assist looking up struct clks
> > for the ARM & SH architecture.
> > 
> > as the code is identical at 99%
> > 
> > put the arch specific code for allocation as example in asm/clkdev.h
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> is it ok?

Just applied it and dropped it - it seems to miss deleting the old files.
Please resubmit with the old files removed.

BTW, patch system understands git -C and -M patches.
