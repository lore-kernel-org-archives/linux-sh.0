From: Simon Horman <horms@verge.net.au>
Date: Fri, 16 Nov 2012 00:02:21 +0000
Subject: Re: [PATCH] ARM: shmobile: mackerel: Add FLCTL IRQ resource
Message-Id: <20121116000220.GB20637@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1352803609-16669-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1352803609-16669-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 15, 2012 at 10:13:51AM +0100, Bastian Hecht wrote:
> Hello Simon,
> 
> > could you provide a little more information on:
> > * Why this is so. Is it related to a change in another commit?
> 
> Oh sure. So, the error IRQ was introduced in commit 3c7ea4eccfd2e mtd:
> sh_flctl: Add support for error IRQ.
> It notifies us when the actual communication from our flash controller
> to the NAND chip fails.
> 
> > * What the implications are of this change not being applied:
> >   the driver doesn't work?
> 
> Yes the driver refuses to start up if the error IRQ is missing.
> 
> Do you think I should include such information into the commit
> message, or is it just helpful for the upstream process?

Yes. Please re-post the patch with a revised commit message
that includes the information above.
