From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 11 Sep 2013 07:03:27 +0000
Subject: Re: [PATCH 2/5] i2c: rcar: get clock rate only once and simplify calculation
Message-Id: <Pine.LNX.4.64.1309110854200.26942@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1378742120-11135-1-git-send-email-g.liakhovetski@gmx.de>
 <1378742120-11135-3-git-send-email-g.liakhovetski@gmx.de>
 <CANqRtoRF8CD4hO4m23dqAtNCKvAqHo-+JhZud43SYePB4w5Ong@mail.gmail.com>
In-Reply-To: <CANqRtoRF8CD4hO4m23dqAtNCKvAqHo-+JhZud43SYePB4w5Ong-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>

Hi Magnus

Thanks for your comments

On Wed, 11 Sep 2013, Magnus Damm wrote:

> Hi Guennadi,
> 
> On Tue, Sep 10, 2013 at 12:55 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > There is no need to repeatedly query clock frequency, where it is not
> > expected to change. The complete loop can also trivially be replaced with
> > a simple division. A further loop below the one, being simplified, could
> > also be replaced, but that would get more complicated.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> 
> Thanks for your efforts. What makes you think that you should assume
> that the clock frequency doesn't change?

Sorry, maybe I didn't explain well enough in the patch description. 
Please, have a look at the patch. It removes repeated clock rate readings 
inside a tight loop. I'm aware that the clock rate can change, but there 
should be a way to make sure, that beginning now and until a certain later 
point of time the rate doesn't change. Presumably this should be done by 
locking the clock. I'm not sure this is currently supported by the clock 
API. Neither clk_get(), nor clk_prepare() nor clk_enable() seem to have 
the semantics of locking the clock's frequency. Maybe the one who actually 
prepared the clock should become its owner, but I don't think this is 
currently the expected behaviour. In either case, I don't think calling 
clk_get_rate() repeatedly inside _that_ loop makes sense - the rate can 
anyway be changed after the loop, so, it doesn't add any security.

Thanks
Guennadi

> As you already know, we want drivers to be reusable across multiple
> SoCs. Assuming it that it would be fixed based on one particular SoC
> doesn't guarantee that that's the case on other SoCs. Which SoCs did
> you take into consideration?

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
