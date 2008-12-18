From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 18 Dec 2008 16:24:40 +0000
Subject: Re: A patch got applied to v4l bypassing v4l lists
Message-Id: <20081218162439.GA27151@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0812181613050.5510@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0812181613050.5510@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 18, 2008 at 05:22:22PM +0100, Guennadi Liakhovetski wrote:
> On Fri, 19 Dec 2008, Paul Mundt wrote:
> > If you wish to be CC-ed on all trivial patches relating to sh drivers in
> > the v4l space, that is certainly something we can watch out for in the
> > future, but I will still be applying the patches where it makes sense.
> 
> I certainly understand, that the patch in question didn't contain any 
> video specidic code, and you both are well able to justify its 
> correctness, I'm just saying that because of the way v4l patches are 
> handled it causes extra work, and not even knowing about such patches adds 
> the necessity to search for them first - ok, thanks to git-blame it wasn't 
> very difficult this time, but if the code had been removed, for instance, 
> it could have been a bit trickier. So, yes, please, at least cc the v4l 
> list on such patches.
> 
It should not cause extra work at all. The only time it may cause extra
work is if you are talking about splitting up the patch and pulling in
the v4l specific parts in to your v4l tree. My point is that this is
absolutely the wrong thing to do, since the changes are tied together for
a reason.

The last time you went down this splitting of the patch path you
completely broke bisection for us for an extended period of time, and
choosing policy over functionality is simply not something I will be part
of. If you want to split the patch up and merge parts in to your own
tree, that is perfectly fine, but it is both unnecessary, and I will
still be merging the change including its dependencies in one shot
without the split in my own tree so as to not break bi-section.

If v4l has a policy that anything modifying drivers/media in anyway
whatsoever needs to be split out and merged through the v4l tree, you
might consider rethinking your policy and reshaping it in to something
that actually makes sense. Breaking bisection is not acceptable, period.
