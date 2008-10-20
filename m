From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Oct 2008 12:45:39 +0000
Subject: Re: [PATCH] soc-camera: fix compile breakage on SH
Message-Id: <20081020124539.GA20548@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0810142335400.10458@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0810142335400.10458@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 20, 2008 at 09:02:26AM +0200, Guennadi Liakhovetski wrote:
> On Mon, 20 Oct 2008, Paul Mundt wrote:
> > I don't like this. Keeping the enable and disable_camera interfaces
> > is really the way we want to go, evident by the fact that your new power
> > callback is forced to call in to one or the other anyways. I would rather
> > see these moved in to struct soc_camera_platform_info, rather than having
> > every single board in existence have to model that if (mode) on; else off
> > crap.
> 
> The v4l counterpart of this patch has already been accepted. And since 
> this is a compilation breakage fix, I think it would be better to apply it 
> as is now, and then we can discuss better APIs.
> 
I don't see how you can call this a fix, since it doesn't actually fix
the situation unless both parts are applied at the same time.

> Eventually, these power callback should disappear from struct 
> soc_camera_platform_info and it should instead inclde struct 
> soc_camera_link, which already has it. Then we can split "power" into a 
> disable / enable pair.
> 
That sounds fine.

> > Also, there is not much point in splitting these changes out. They are
> > coupled, and splitting them out only causes confusion (especially across
> > a bisect).
> 
> This is why I originally have sent it as a single patch. But since I have 
> got no acks I decided it would be easier to split it and have parts 
> committed separately.

I am not interested in merging something that is broken until the v4l
tree syncs up. If the v4l part is already merged, then we don't have a
lot of choice in what to do on the platform side. I will take your
original patch that touches both the platform and the v4l code and merge
that, then later when the v4l code tries to sync up git merging should do
the right thing.

In the future, if you do not immediately get acks, please do not assume
it is because there is a problem with your approach and that you should
suddenly try random different approaches until you start getting
feedback. In my case I was traveling and was way behind on email.

Splitting patches up that depend on each other is not acceptable, since
you introduce breakage as soon as you change the API and fail to update
the users at the same time. Subsystems should absolutely not be merging
those sorts of changes, since this causes nothing but pain for the users
that only find out about the changes when the build blows up, as seems to
have been the case in the initial merge also.
