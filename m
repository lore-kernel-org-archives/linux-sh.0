From: Simon Horman <horms@verge.net.au>
Date: Mon, 13 Jan 2014 00:12:44 +0000
Subject: Re: [PATCH] ARM: shmobile: clk_get() returns error code on failure
Message-Id: <20140113001244.GB15296@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1389281623-10253-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1389281623-10253-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 10, 2014 at 11:36:10AM +0000, Ben Dooks wrote:
> On 10/01/14 01:23, Simon Horman wrote:
> >On Thu, Jan 09, 2014 at 06:42:38PM +0100, Laurent Pinchart wrote:
> >>Hi Ben,
> >>
> >>Thank you for the patch.
> >>
> >>On Thursday 09 January 2014 15:33:43 Ben Dooks wrote:
> >>>The lager_add_standard_devices() function calls clk_get() but then fails
> >>>to check that it returns an error pointer instead of NULL on failure.
> >>>
> >>>Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> >>>Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
> >>
> >>Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>
> >>Do you plan to submit a similar patch for board-koelsch-reference.c ? I don't
> >>mind doing it.
> >
> >Hi Ben,
> >
> >does this fix a problem that you have obvserved in practice.
> >If so it might be worth trying to get it included as a fix
> >for v3.14 rather than queueing it up for v3.15.
> >
> >Regardless, as it is a fix of sorts, could you please include some
> >information along the following lines in the changelog:
> >
> >----
> >This problem has been present since xyz was added by
> >deadbeef0123456789f ("ARM: shmobile: lager: something goes here")
> >in v3.1X-rcY.
> >----
> 
> Ok, will update. However it is not actually a bug we've noticed
> yet, just an observation whilst hunting down other issues.

Thanks. In that case I will queue if up for v3.15 once you have
revised the changelog.
