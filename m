From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 25 Oct 2010 11:13:25 +0000
Subject: Re: [PATCH] sh: i2c-sh7760: Replase from ctrl_* to __raw_*
Message-Id: <20101025111324.GA16265@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1287785220-5893-1-git-send-email-iwamatsu@nigauri.org> <20101025015835.GE2173@linux-sh.org> <20101025104718.GF21564@trinity.fluff.org>
In-Reply-To: <20101025104718.GF21564-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Oct 25, 2010 at 11:47:18AM +0100, Ben Dooks wrote:
> On Mon, Oct 25, 2010 at 10:58:35AM +0900, Paul Mundt wrote:
> > On Sat, Oct 23, 2010 at 07:07:00AM +0900, Nobuhiro Iwamatsu wrote:
> > > ctrl_* is deprecated. We should to use __raw_*.
> > > 
> > > Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > 
> > Applied, thanks.
> 
> Hi, can you see my comments about the copy of this posted below
> about ioremap() and use or __raw accessors?
> 
No? At least it never made it to the list. Do you have a pointer handy?
