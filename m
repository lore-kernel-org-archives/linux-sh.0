From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 15 Sep 2009 23:42:19 +0000
Subject: Re: User mode address error problems on 7763
Message-Id: <20090915234218.GC23923@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
In-Reply-To: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 15, 2009 at 09:43:13AM -0500, Dale Larson wrote:
> > Great, your libc doesn't handle variable page sizes. You're either going
> > to have to update and rebuild your libc, or go back to the write-through
> > caching on 4k pages thing. The latter should be fine in the current tree,
> > as I've tested it on a number of boards. If you run in to issues with
> > that, please post a full boot log for that also.
> 
> I changed to write-through cache and it runs much better. I ran two
> ssh session with "du /" and "find /" looping on those sessions and
> "top" running on the console. Eventially the 'top' session crashed and
> the ssh sessions stopped generating output. Here's the dump (craddle
> to grave) with many 'top''s removed:
> 
So basically it looks like there are two separate bugs here, one is an
aliasing issue that we need to address separately, and this one appears
to be slab corruption. Do you know roughly which previous kernel worked
for you? If so, that at least gives us a starting point for comparison.

In any event, given that this is a slab issue, this should likely be
reported to kerneloops.org, then it's possible to see if there are others
that end up with similar issues and similar callchains.
