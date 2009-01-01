From: Steve.Glendinning@smsc.com
Date: Thu, 01 Jan 2009 12:58:32 +0000
Subject: Re: SH7709 BUG on boot (partially bisected)
Message-Id: <OF27945C1E.C7FFE91D-ON80257531.00459EBC-80257531.004762ED@smsc.com>
List-Id: <linux-sh.vger.kernel.org>
References: <OF2E8062F8.007117EA-ON80257530.004D178D-80257530.004E3CFB@smsc.com>
In-Reply-To: <OF2E8062F8.007117EA-ON80257530.004D178D-80257530.004E3CFB@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

HI Paul,

> > Using the current torvalds tree on SH7709, physmap is having a problem 

> > seeing my memory-mapped flash.  I've bisected this to somewhere 
between:
> > 
> > GOOD: [e9bf51e5ccc7703226c79888603e157066213700] sh: __udivdi3 -> 
do_div() 
> > in softfloat lib.
> > BAD: [3b041227f7ef7c7e97f205c68c6069c0c62e5204] sh: Add plain udivsi3 
(not 
> > _i4*) for gcc-4.1 and lower.
> > 
> > All commits between these two fail to boot here (no console output at 
> > all), so I wasn't able to bisect further.
> > 
> Can you post your toolchain information? Compiler version is the most
> important thing here.

I've upgraded to the gcc 4.1.1 rpm (also from rpm.linux-sh.org).  The 
problem is still there but the messages I see are different: The BUG has 
been replaced with "map_probe failed".

    physmap platform flash device: 01000000 at 00000000
    physmap-flash physmap-flash.0: map_probe failed

Obviously later on I get a panic as it can't see its root fs.

The same revisions as before are good and bad, and I still get no console 
output from commits in-between the two so I'm unable to bisect further.

Regards,
--
Steve Glendinning
SMSC GmbH
m: +44 777 933 9124
e: steve.glendinning@smsc.com

