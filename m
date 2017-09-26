From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Tue, 26 Sep 2017 13:04:54 +0000
Subject: Re: Bug report: kernel BUG at arch/sh/kernel/dwarf.c:547!
Message-Id: <20170926150454.5d37f99c@windsurf.lan>
List-Id: <linux-sh.vger.kernel.org>
References: <20170926142902.36e9539e@windsurf.lan>
In-Reply-To: <20170926142902.36e9539e@windsurf.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

On Tue, 26 Sep 2017 14:55:44 +0200, John Paul Adrian Glaubitz wrote:

> > It's a custom platform using the SH7786 SoC. Sadly, this is clearly not
> > a HW platform that I can provide to help Debian having more build
> > resources.  
> 
> I assume this is some custom hardware used for automotive or industrial
> applications?

Yes, correct.

> > Let's see if Rich and/or Yoshinori have some feedback about my issue.  
> 
> Yoshinori is currently not active in kernel development but from what
> I have heard, he was planning to return soonish. In any case, I just
> want to avoid that your issue gets lost on the mailing lists.

Rich has been active recently on SuperH related topics, and has a very
solid toolchain related background. So perhaps he'll have some insight
about this DWARF issue.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
