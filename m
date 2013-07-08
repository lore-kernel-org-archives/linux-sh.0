From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 08 Jul 2013 11:17:41 +0000
Subject: Re: [PATCH/RFC v2 4/4] ARM: shmobile: APE6EVM-reference: add ethernet support
Message-Id: <Pine.LNX.4.64.1307081312560.19819@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1373038006-19973-5-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373038006-19973-5-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, 8 Jul 2013, Magnus Damm wrote:

> On Mon, Jul 8, 2013 at 7:46 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:

[snip]

> > been there, done that (for sh_eth):
> >
> > http://thread.gmane.org/gmane.linux.ports.sh.devel/18859
> >
> > It didn't go anywhere. My current status is - I have no idea what
> > networking people assume is the right way to reset ethernet phys.
> 
> But the SMSC911X chip is not an ethernet PHY. It's an external
> Ethernet controller.

Sure, sorry, so, if both have to be solved, solutions might be different.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
