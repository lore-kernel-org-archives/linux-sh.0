From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 12 Nov 2013 23:14:37 +0000
Subject: Re: [PATCH v2 10/19] mtd: sh_flctl: Enable the driver on all ARM platforms
Message-Id: <1701001.ctJ1xUAsnV@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383086274-11049-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131112231020.GA9468@ld-irv-0074.broadcom.com>
In-Reply-To: <20131112231020.GA9468@ld-irv-0074.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Brian,

On Tuesday 12 November 2013 15:10:20 Brian Norris wrote:
> On Tue, Oct 29, 2013 at 11:37:45PM +0100, Laurent Pinchart wrote:
> > Renesas ARM platforms are transitioning from single-platform to
> > multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> > driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> > and ARCH_SHMOBILE_MULTI, and increase build testing coverage with
> > COMPILE_TEST.
> > 
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: linux-mtd@lists.infradead.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Applied to l2-mtd.git, branch 'next' (for 3.14). Thanks.

Thank you, but if it's not too late, can you drop the patch ? :-) We've 
settled for a different approach that renames Kconfig symbols and doesn't 
require changes to individual drivers.

-- 
Regards,

Laurent Pinchart

