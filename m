From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 22 Jun 2010 06:18:41 +0000
Subject: Re: [sh7785lcr proto] fails to boot since commit 6430a5987f8bb9a7c5187b343956aa8ef404d571
Message-Id: <20100622061840.GA15958@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4C14ACDD.6050004@gentoo.org>
In-Reply-To: <4C14ACDD.6050004@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 22, 2010 at 02:01:27PM +0900, Nobuhiro Iwamatsu wrote:
> 2010/6/18 Ra?l Porcel <armin76@gentoo.org>:
> > On 06/13/2010 12:03 PM, Ra?l Porcel wrote:
> >> Hello list,
> >>
> >> I tried some weeks to upgrade the sh7785lcr prototype board using 32bits
> >> to the latest released kernel(2.6.34.something). I've also tried with
> >> latest git.
> >>
> > <snip>
> >
> > By Matt Fleming's request i've tested latest git again, and turns out
> > that if i run the 'pmb' command on the 32bit uboot, the kernel boots.
> >
> > So i believe this is 'fixed'.
> 
> Yes, This is correct.
> If you want to boot 32bit kernel, you need run pmb command.
> 
This has always been the case though, so I'm confused as to what you
think changed between the older and current kernels?
