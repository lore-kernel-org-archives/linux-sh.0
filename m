From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Wed, 11 Mar 2009 06:50:03 +0000
Subject: Re: [PATCH] sh: hibernation support
Message-Id: <49B75F1B.7070604@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus.

> Thanks for your help! I tested your patch but I need the attached fix.
>
> Can you please include my fix and resubmit inline? Feel free to add an
> ack from me.
>   
Ok.
While we are 'fixing' the clock framework on resume from hibernation.
I'd like to do some similar thing on suspend/resume from standby.
I was thinking to add some flags/capability able to say to the framework 
what it has to be done in standby.
Something like:

#define CLK_TURNOFF_ON_SUSPEND   ....
#define CLK_REDUCE_ON_SUSPEND ...

In this manner in the single file where the clock tree is described we 
have a clear view of all the scenario
 (normal runtime, suspend, hibernation)...
Moreover this should not impact "medium" power level.
Regards
 Francesco
