From: Steve.Glendinning@smsc.com
Date: Mon, 05 Jan 2009 11:32:49 +0000
Subject: Fw: SH7709 BUG on boot (partially bisected)
Message-Id: <OF78FD2628.616675FB-ON80257535.003E96C0-80257535.003F89DE@smsc.com>
List-Id: <linux-sh.vger.kernel.org>
References: <OF2E8062F8.007117EA-ON80257530.004D178D-80257530.004E3CFB@smsc.com>
In-Reply-To: <OF2E8062F8.007117EA-ON80257530.004D178D-80257530.004E3CFB@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

> > Can you post your toolchain information? Compiler version is the most
> > important thing here.
>
> I've upgraded to the gcc 4.1.1 rpm (also from rpm.linux-sh.org). 

Sorry, that should be rpm.sh-linux.org.

Doh, since Friday Linus's tree #errors on gcc 4.1.{0,1}.  Is there a more 
recent version available as a binary, or should I build my own cross 
toolchain (crosstool?)?

Is there a specific gcc version you'd recommend for sh cross compilation?

Thanks for your help,
--
Steve Glendinning
SMSC GmbH
m: +44 777 933 9124
e: steve.glendinning@smsc.com


