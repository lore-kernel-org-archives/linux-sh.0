From: Peter Griffin <pgriffin@mpc-data.co.uk>
Date: Tue, 12 May 2009 08:38:51 +0000
Subject: Re: [PATCH] Add ptrace support for NOMMU debugging
Message-Id: <1242117531.32597.17.camel@quercus-bis>
List-Id: <linux-sh.vger.kernel.org>
References: <1241794254.16311.32.camel@quercus-bis>
In-Reply-To: <1241794254.16311.32.camel@quercus-bis>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 2009-05-08 at 14:28 -0400, Mike Frysinger wrote:
> On Friday 08 May 2009 10:50:54 Peter Griffin wrote:
> > >From 2652ec6503dbe78e5bf371b77544e168166aa57d Mon Sep 17 00:00:00 2001
> >
> > From: Peter Griffin <pgriffin@mpc-data.co.uk>
> > Date: Fri, 8 May 2009 15:01:21 +0100
> > Subject: [PATCH] Add ptrace support for NOMMU debugging
> 
> are you not using git-send-email ?  posting the actual file produced by git-
> format-patch looks weird (not sure if git-am works with this).
Hi Mike,

I was using git-format-patch to generate the patches, and then evolution
in 'pre-format' mode to insert the patch file and send the email.

I've not used git-send-email before, but I just installed it on my
system and it looks really good. I especially like the look of the
--signed-off-by-cc option :-)

> > +		else if ( addr = PT_TEXT_ADDR)
> > +			tmp = child->mm->start_code;
> > +		else if ( addr = PT_DATA_ADDR)
> > +			tmp = child->mm->start_data;
> > +		else if ( addr = PT_TEXT_END_ADDR )
> > +			tmp = child->mm->end_code;
> > +		else if ( addr = PT_TEXT_LEN )
> > +			tmp = child->mm->end_code - child->mm->start_code;
> 
> style wrong: no space inside of those parenthesis
> -mike
Noted, thanks for pointing it out. Paul fixed this for me when
committing.

regards,

Peter.

