From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Oct 2008 13:08:17 +0000
Subject: Re: [PATCH] soc-camera: fix compile breakage on SH
Message-Id: <20081020130817.GC20548@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0810142335400.10458@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0810142335400.10458@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 20, 2008 at 03:00:25PM +0200, Guennadi Liakhovetski wrote:
> On Mon, 20 Oct 2008, Paul Mundt wrote:
> > I don't see how you can call this a fix, since it doesn't actually fix
> > the situation unless both parts are applied at the same time.
> 
> It will be fixed _after_ both parts are committed, even if not at the same 
> time.
> 
_after_ = broken bisection, so therefore it is as good as no fix.

> > > This is why I originally have sent it as a single patch. But since I have 
> > > got no acks I decided it would be easier to split it and have parts 
> > > committed separately.
> > 
> > I am not interested in merging something that is broken until the v4l
> > tree syncs up. If the v4l part is already merged, then we don't have a
> > lot of choice in what to do on the platform side.
> 
> Last I checked - just before sending the previous email - it was not yet 
> committed, but it is racy, you know:-)
> 
Then I will merge the original in my tree and we can then focus on
getting the API changed properly, and making an incremental transition
that doesn't break all of the existing users in the process.

> > I will take your
> > original patch that touches both the platform and the v4l code and merge
> > that, then later when the v4l code tries to sync up git merging should do
> > the right thing.
> 
> Will it? ok, didn't know that. Then it's ok indeed.
> 
Yes, unfortunately this results in reproduced metadata, but it is a
necessary evil. This sort of situation often arises with platform data
API changes, so you see it quite frequently in architecture code. This
sort of bump in the workflow is necessary in order not to break the tree
however.

> > Splitting patches up that depend on each other is not acceptable, since
> > you introduce breakage as soon as you change the API and fail to update
> > the users at the same time. Subsystems should absolutely not be merging
> > those sorts of changes, since this causes nothing but pain for the users
> > that only find out about the changes when the build blows up, as seems to
> > have been the case in the initial merge also.
> 
> I don't think all subsystem maintainers would agree with you here. I have 
> been explicitly asked before to split such patches and just explain in the 
> dependent patch, that it should be applied after the one it depends upon.
> 
Yeah, the subsystem maintainers that don't have their platform broken
because of the API changes would tend not to have a strong opinion one
way or the other. In the case where there are lots of users all over the
place, one usually makes a best effort to get those all converted at the
same time, but obviously some fall through the cracks, and we deal with
that breakage as it happens. In this case there are very very few users,
so this simply should not have happened.

If subsystem people want to argue that breaking bisection is perfectly
acceptable, lets move this to linux-kernel and make sure Linus is on the
Cc.

Making incremental dependent patches is perfectly fine, as long as you do
not break the state of the tree in between any of those incremental
changes. If you are doing an API change you do need to get the user
updates in the same update, if you are not providing backwards
compatability for the old behaviour. It is never acceptable to willfully
break the tree in the name of having something split out.
