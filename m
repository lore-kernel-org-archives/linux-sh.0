From: Simon Horman <horms@verge.net.au>
Date: Fri, 19 Aug 2011 03:26:55 +0000
Subject: Re: [PATCH] mmc: sdhi: initialise mmc_data->flags before use
Message-Id: <20110819032648.GA12106@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1313716027-19470-1-git-send-email-horms@verge.net.au>
 <CANqRtoRx5MC-smUjuYBgpstcm49_PqwXqG=YEe+dkqVte7eQ9w@mail.gmail.com>
In-Reply-To: <CANqRtoRx5MC-smUjuYBgpstcm49_PqwXqG=YEe+dkqVte7eQ9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Fri, Aug 19, 2011 at 12:04:06PM +0900, Magnus Damm wrote:
> On Fri, Aug 19, 2011 at 10:07 AM, Simon Horman <horms@verge.net.au> wrote:
> > This corrects a logic error that I introduced in
> > "mmc: sdhi: Add write16_hook"
> >
> > Reported-by: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> >  drivers/mmc/host/sh_mobile_sdhi.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> Hi Simon,
> 
> Thanks for providing a fix for this issue. Correct me if I'm wrong,
> but I believe this patch is suitable for 3.1-rc. So it would be great
> to have it merged rather soon as a fix instead of delaying it to 3.2.

Yes, I agree.
