From: Steve.Glendinning@smsc.com
Date: Mon, 05 Jan 2009 12:48:26 +0000
Subject: Re: Fw: SH7709 BUG on boot (partially bisected)
Message-Id: <OFBB0A3BAE.0B5CA241-ON80257535.0044FF11-80257535.00467619@smsc.com>
List-Id: <linux-sh.vger.kernel.org>
References: <OF2E8062F8.007117EA-ON80257530.004D178D-80257530.004E3CFB@smsc.com>
In-Reply-To: <OF2E8062F8.007117EA-ON80257530.004D178D-80257530.004E3CFB@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Thanks Paul,

With your gcc 4.2.1 toolchain and today's linus git tree my platform's 
physmap flash works again.  I also tested the "bad" revision from my 
bisection and this also works fine with gcc 4.2.1.

I'll use 4.2.1 from now onwards, so I'm happy, but if this is still 
something you still want to fix I'm happy to test patches with 3.4.4.

Steve

--
Steve Glendinning
SMSC GmbH
m: +44 777 933 9124
e: steve.glendinning@smsc.com



Paul Mundt <lethal@linux-sh.org> wrote on 05/01/2009 11:54:45:

> On Mon, Jan 05, 2009 at 11:32:49AM +0000, Steve.Glendinning@smsc.com 
wrote:
> > Hi Paul,
> > 
> > > > Can you post your toolchain information? Compiler version is the 
most
> > > > important thing here.
> > >
> > > I've upgraded to the gcc 4.1.1 rpm (also from rpm.linux-sh.org). 
> > 
> > Sorry, that should be rpm.sh-linux.org.
> > 
> > Doh, since Friday Linus's tree #errors on gcc 4.1.{0,1}.  Is there a 
more 
> > recent version available as a binary, or should I build my own cross 
> > toolchain (crosstool?)?
> > 
> > Is there a specific gcc version you'd recommend for sh cross 
compilation?
> > 
> There are a couple binary toolchains at:
> 
> http://userweb.kernel.org/~lethal/toolchains/
> 
> beyond that, you can find some more links on the wiki.
> 
> I generally stick with gcc 4.2.x, although have been doing 4.3.x also
> recently. The binutils versions tend not to matter too much, in that 
they
> tend to have very little churn in the sh backend.

