From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Tue, 26 Sep 2017 12:52:57 +0000
Subject: Re: Bug report: kernel BUG at arch/sh/kernel/dwarf.c:547!
Message-Id: <20170926145257.66f6596c@windsurf.lan>
List-Id: <linux-sh.vger.kernel.org>
References: <20170926142902.36e9539e@windsurf.lan>
In-Reply-To: <20170926142902.36e9539e@windsurf.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

On Tue, 26 Sep 2017 14:36:42 +0200, John Paul Adrian Glaubitz wrote:

> On 09/26/2017 02:29 PM, Thomas Petazzoni wrote:
> > I'm using Linux 4.13 on a big endian SH4A system,  
> 
> Wow, that's the first time I hear someone use SuperH in Big-Endian mode.

Hehe, yes, I know, it's pretty uncommon. The hardware platform I'm
using was not running Linux... until now. And the big endian choice is
made at the HW level, so it's not trivial to change it to little endian.

> May I ask what kind of hardware you are using? I'm still looking for
> new/used SH4 boards to add additional buildd resources in Debian.

It's a custom platform using the SH7786 SoC. Sadly, this is clearly not
a HW platform that I can provide to help Debian having more build
resources.

> > You'll find below the full kernel panic log. You'll also notice that
> > the layout of the kernel panic message is really weird, with many
> > newlines all over the place, which probably is another bug.  
> I think it might be a better idea to report this issue to the kernel
> bugzilla [1] so your bug report doesn't get lost. SuperH can now be
> selected as the target architecture, too.

I thought about this, but I'm not sure the SH maintainers are actively
looking at the kernel bug tracker.

Let's see if Rich and/or Yoshinori have some feedback about my issue.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
