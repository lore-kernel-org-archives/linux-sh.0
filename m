From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 19 Dec 2012 21:24:10 +0000
Subject: Re: [PATCH v3 00/81] SH pin control and GPIO rework
Message-Id: <1586031.1BSJIX9nKm@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1355611915-25060-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1355611915-25060-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

On Wednesday 19 December 2012 16:31:00 Linus Walleij wrote:
> On Sat, Dec 15, 2012 at 11:50 PM, Laurent Pinchart wrote:
> > I would like to push this set to v3.9 independently of the later rework
> > and OF-related sets. Linus and Simon, which tree would you like me to push
> > this through ?
> 
> The pinctrl or sh tree obviously :-)
> 
> Basically if you believe there will be colissions with other stuff in
> the sh tree it should go in through that tree. Obviously there is little
> risk of collissions in the pinctrl tree as this is a new driver.

I believe the risk of collisions in the SH and ARM trees are higher than in 
the pinctrl tree, so it would probably better to push the patches through 
Simon.

> You can add my Acked-by: to the entire patch set, since the result at
> the end is super-nice.

Thank you.

I'll push a public branch on top of v3.8-rc1 when it will be released, and 
will send a pull request a couple of weeks later.

> I think there were review comments of mine that were not fixed yet,
> but I trust you to go through that and fix it up as time goes by.

They will be addressed by new patch series. This one is already pretty big, I 
didn't want to delay it anymore.

-- 
Regards,

Laurent Pinchart

