From: Jason Cooper <jason@lakedaemon.net>
Date: Sun, 09 Nov 2014 04:30:10 +0000
Subject: Re: [PATCH V4 00/14] genirq endian fixes; bcm7120/brcmstb IRQ updates
Message-Id: <20141109043010.GR3698@titan.lakedaemon.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
 <20141107122745.GJ3698@titan.lakedaemon.net>
In-Reply-To: <20141107122745.GJ3698-u4khhh1J0LxI1Ri9qeTfzeTW4wlIGRCZ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org, jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org

On Fri, Nov 07, 2014 at 07:27:45AM -0500, Jason Cooper wrote:
> Thomas,
> 
> On Thu, Nov 06, 2014 at 10:44:15PM -0800, Kevin Cernekee wrote:
> > V3->V4:
> > 
> >  - Fix buildbot bisectability warning on patch 02/14 (missing include)
> 
> Dammit.  :(  Even if I had created a topic branch for this series, I
> still would have put the genirq changes in /core, then based a brcm
> branch off of that.
> 
> I'm inclined to think I should just drop v3 and apply v4, as a revert
> commit wouldn't solve the bisectability issue.

Ok, no complaints, so it's done.

thx,

Jason.
