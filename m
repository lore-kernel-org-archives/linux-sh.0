From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 26 Aug 2014 12:41:33 +0000
Subject: Re: [PATCH 3/6] clk: shmobile: Add r8a7794 support
Message-Id: <3318962.0jadY4SVgu@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1406299250-23975-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1406299250-23975-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Tuesday 26 August 2014 20:50:53 Magnus Damm wrote:
> Hi Mike,
> 
> [CC Simon and Laurent]
> 
> On Sat, Jul 26, 2014 at 4:44 AM, Mike Turquette wrote:
> > Quoting Ulrich Hecht (2014-07-25 07:40:47)
> > 
> >> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> >> 
> >> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> >> Cc: Mike Turquette <mturquette@linaro.org>
> > 
> > Acked-by: Mike Turquette <mturquette@linaro.org>
> 
> Thanks!
> 
> > Are you taking this through arm-soc?
> 
> Good question. Simon, do you have any preference how to merge this?
> 
> Perhaps Laurent remembers how we dealt with the earlier SoCs?

As far as git log remembers, they have been merged through Mike's tree.

It all depends on how we want to merge the rest of the series. The risk of 
conflict on this specific patch is low, so it can go through Simon's tree if 
it helps resolving dependencies with the rest of the series.

-- 
Regards,

Laurent Pinchart

