From: Steve.Glendinning@smsc.com
Date: Thu, 01 Jan 2009 11:43:38 +0000
Subject: Re: SH7709 BUG on boot (partially bisected)
Message-Id: <OF20410E70.180A7ED5-ON80257531.00402089-80257531.0040871D@smsc.com>
List-Id: <linux-sh.vger.kernel.org>
References: <OF2E8062F8.007117EA-ON80257530.004D178D-80257530.004E3CFB@smsc.com>
In-Reply-To: <OF2E8062F8.007117EA-ON80257530.004D178D-80257530.004E3CFB@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

> Can you post your toolchain information? Compiler version is the most
> important thing here.

I'm using an rpm-based cross toolchain from 
http://rpm.sh-linux.org/rpm-2004/host/RPMS/:

gcc-sh-linux-3.4.4-1.i386.rpm
binutils-sh-linux-2.16.1-2.i386.rpm
glibc-sh-linux-2.3.3-27.12.noarch.rpm
glibc-sh3-linux-2.3.3-27.12.noarch.rpm

I notice there are some newer toolchains on that site now, which of these 
should I be using?

Regards,
--
Steve Glendinning
SMSC GmbH
m: +44 777 933 9124
e: steve.glendinning@smsc.com



Paul Mundt <lethal@linux-sh.org> wrote on 31/12/2008 23:29:51:

> On Wed, Dec 31, 2008 at 02:13:23PM +0000, Steve.Glendinning@smsc.com 
wrote:
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

