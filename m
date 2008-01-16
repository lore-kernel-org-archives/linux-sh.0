From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 16 Jan 2008 10:17:47 +0000
Subject: Re: What's in sh-2.6.git for 2.6.25?
Message-Id: <20080116101747.GA26235@uranus.ravnborg.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080116070403.GA14107@linux-sh.org> <20080116073844.GA25205@uranus.ravnborg.org> <20080116093718.GB14107@linux-sh.org>
In-Reply-To: <20080116093718.GB14107@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 16, 2008 at 06:37:18PM +0900, Paul Mundt wrote:
> On Wed, Jan 16, 2008 at 08:38:44AM +0100, Sam Ravnborg wrote:
> > On Wed, Jan 16, 2008 at 04:04:03PM +0900, Paul Mundt wrote:
> > > This is a brief summary of the changes that are sitting in the sh queue
> > > for 2.6.25.
> > > 
> > > The main points to note are as follows:
> > > 
> > > 	- sh64->sh integration.
> > > 	- A handful of new CPUs (SH7721, SH7763, SH7203, SH7263).
> > > 	- SH-2A FPU support.
> > > 	- Board support updates (R2D, R7785RP).
> > > 
> > > The sh64->sh integration is basically the only thing that's really
> > > interesting, and so it's worth summarizing that a bit.
> > 
> > Any kbuild bits that needs an extra pair of eyes before
> > integration or can I postpone my review until it hits mainline?
> > If you feel confident I prefer to wait as I'm busy atm.
> > 
> Most of the kbuild bits have been pretty painless. I started out going
> the SRCARCH route, but that ended up creating a lot of additional
> duplication, so I opted to just roll them together and stick with abusing
> KCONFIG_ALLCONFIG for restricting the options. Based on the heavy sharing
> between the Kconfig options, this seemed to be the best way to go.
> 
> So, I'm reasonably content with it the way it is, but any input you have
> on cleaning it up is certainly welcome at any time :-)

I will take a look when it hits mainline then.
Ping me if you do not hear from me.

	Sam
