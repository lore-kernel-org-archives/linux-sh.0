From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 05 Jan 2009 11:54:45 +0000
Subject: Re: Fw: SH7709 BUG on boot (partially bisected)
Message-Id: <20090105115445.GA21207@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <OF2E8062F8.007117EA-ON80257530.004D178D-80257530.004E3CFB@smsc.com>
In-Reply-To: <OF2E8062F8.007117EA-ON80257530.004D178D-80257530.004E3CFB@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 05, 2009 at 11:32:49AM +0000, Steve.Glendinning@smsc.com wrote:
> Hi Paul,
> 
> > > Can you post your toolchain information? Compiler version is the most
> > > important thing here.
> >
> > I've upgraded to the gcc 4.1.1 rpm (also from rpm.linux-sh.org). 
> 
> Sorry, that should be rpm.sh-linux.org.
> 
> Doh, since Friday Linus's tree #errors on gcc 4.1.{0,1}.  Is there a more 
> recent version available as a binary, or should I build my own cross 
> toolchain (crosstool?)?
> 
> Is there a specific gcc version you'd recommend for sh cross compilation?
> 
There are a couple binary toolchains at:

http://userweb.kernel.org/~lethal/toolchains/

beyond that, you can find some more links on the wiki.

I generally stick with gcc 4.2.x, although have been doing 4.3.x also
recently. The binutils versions tend not to matter too much, in that they
tend to have very little churn in the sh backend.
