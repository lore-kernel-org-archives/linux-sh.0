From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 20 Oct 2008 13:00:25 +0000
Subject: Re: [PATCH] soc-camera: fix compile breakage on SH
Message-Id: <Pine.LNX.4.64.0810201452080.4528@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0810142335400.10458@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0810142335400.10458@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, 20 Oct 2008, Paul Mundt wrote:

> On Mon, Oct 20, 2008 at 09:02:26AM +0200, Guennadi Liakhovetski wrote:
> > 
> > The v4l counterpart of this patch has already been accepted. And since 
> > this is a compilation breakage fix, I think it would be better to apply it 
> > as is now, and then we can discuss better APIs.
> > 
> I don't see how you can call this a fix, since it doesn't actually fix
> the situation unless both parts are applied at the same time.

It will be fixed _after_ both parts are committed, even if not at the same 
time.

> > This is why I originally have sent it as a single patch. But since I have 
> > got no acks I decided it would be easier to split it and have parts 
> > committed separately.
> 
> I am not interested in merging something that is broken until the v4l
> tree syncs up. If the v4l part is already merged, then we don't have a
> lot of choice in what to do on the platform side.

Last I checked - just before sending the previous email - it was not yet 
committed, but it is racy, you know:-)

> I will take your
> original patch that touches both the platform and the v4l code and merge
> that, then later when the v4l code tries to sync up git merging should do
> the right thing.

Will it? ok, didn't know that. Then it's ok indeed.

> In the future, if you do not immediately get acks, please do not assume
> it is because there is a problem with your approach and that you should
> suddenly try random different approaches until you start getting
> feedback. In my case I was traveling and was way behind on email.

I knew that, and the reason I splitted it was not because I assumed it was 
bad, but because the initial intention to get it fixed quickly didn't work 
out, then I decided to go the "normal" path.

> Splitting patches up that depend on each other is not acceptable, since
> you introduce breakage as soon as you change the API and fail to update
> the users at the same time. Subsystems should absolutely not be merging
> those sorts of changes, since this causes nothing but pain for the users
> that only find out about the changes when the build blows up, as seems to
> have been the case in the initial merge also.

I don't think all subsystem maintainers would agree with you here. I have 
been explicitly asked before to split such patches and just explain in the 
dependent patch, that it should be applied after the one it depends upon.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
