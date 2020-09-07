From: Rich Felker <dalias@libc.org>
Date: Mon, 07 Sep 2020 17:44:37 +0000
Subject: Re: [PATCH] sh: fix syscall tracing
Message-Id: <20200907174436.GK3265@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20200903054803.GX3265@brightrain.aerifal.cx>
 <e456a455-62cd-4f76-a69a-84d1e5b4d153@physik.fu-berlin.de>
 <20200903161639.GE3265@brightrain.aerifal.cx>
 <1a3f0f7e-f6e6-db4e-06ad-9c7d560a6265@physik.fu-berlin.de>
In-Reply-To: <1a3f0f7e-f6e6-db4e-06ad-9c7d560a6265@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

On Mon, Sep 07, 2020 at 11:52:20AM +0200, John Paul Adrian Glaubitz wrote:
> Hi Rich!
> 
> On 9/3/20 6:16 PM, Rich Felker wrote:
> >> I can confirm that this patch fixes both strace for me and does not break libseccomp,
> >> I have run the libseccomp testsuite with my patch for SuperH support applied on top
> >> of a rebased libseccomp with the 32-bit fixes. Attaching the testsuite log.
> >>
> >> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > 
> > Great! Thanks!
> 
> Can we still get this merged as a hotfix for 5.9?

Yes, fixes for regressions in the same release cycle are in-scope (the
whole point of having -rc's). I have at least one other fix that needs
to go in too and was just giving it a little time to make sure
everything's ok now and that there are no more.

Rich
