From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Aug 2011 07:06:50 +0000
Subject: Re: [PATCH] mmc: sdhi: initialise mmc_data->flags before use
Message-Id: <Pine.LNX.4.64.1108190902180.11363@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1313716027-19470-1-git-send-email-horms@verge.net.au>
 <CANqRtoRx5MC-smUjuYBgpstcm49_PqwXqG=YEe+dkqVte7eQ9w@mail.gmail.com>
In-Reply-To: <CANqRtoRx5MC-smUjuYBgpstcm49_PqwXqG=YEe+dkqVte7eQ9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Fri, 19 Aug 2011, Magnus Damm wrote:

> On Fri, Aug 19, 2011 at 10:07 AM, Simon Horman <horms@verge.net.au> wrote:
> > This corrects a logic error that I introduced in
> > "mmc: sdhi: Add write16_hook"
> >
> > Reported-by: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> > =A0drivers/mmc/host/sh_mobile_sdhi.c | =A0 =A04 ++--
> > =A01 files changed, 2 insertions(+), 2 deletions(-)
>=20
> Hi Simon,
>=20
> Thanks for providing a fix for this issue. Correct me if I'm wrong,
> but I believe this patch is suitable for 3.1-rc. So it would be great
> to have it merged rather soon as a fix instead of delaying it to 3.2.

Indeed:

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Chris, please, push for 3.1.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
