From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 22 May 2009 04:28:28 +0000
Subject: Re: [PATCH] sh: ap325 camera without i2c driver fix
Message-Id: <20090522042828.GA11637@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090520143006.8314.55548.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090520143006.8314.55548.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 22, 2009 at 01:14:51PM +0900, Magnus Damm wrote:
> On Fri, May 22, 2009 at 2:45 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Wed, May 20, 2009 at 11:30:06PM +0900, Magnus Damm wrote:
> >> This patch fixes the ap325rxa ncm03j camera code to handle
> >> the case where no i2c driver is present. Without this fix
> >> i2c_transfer() may be passed NULL as adapter which results
> >> in a crash.
> >>
> >> Triggered when i2c-sh_mobile.c failed to probe() due to
> >> missing MSTP clocks.
> >
> > On Wed, May 20, 2009 at 11:34:43PM +0900, Magnus Damm wrote:
> >> This patch fixes the LCDC driver to avoid calling the
> >> function sh_mobile_lcdc_start_stop(priv, 0) unless the
> >> same function has been called before to start the LCDC
> >> hardware.
> >>
> >> Triggered when sh_mobile_lcdcfb.c failed to probe() due to
> >> missing MSTP clocks.
> >
> > I was going to apply these, but as you provided no information as to what
> > branch these should be applied to, I didn't bother. Is this a problem
> > only in sh/clkfwk? Is this a problem with HEAD? Does it need to go in
> > 2.6.30? If you are going to post a bunch of seemingly unrelated patches
> > in one go, it helps to know what exactly you want done with them.
> 
> These fixes are not sh/clkfwk specific. Does the branch modify these drivers?
> 
No, but there are plenty of MSTP related changes. If you are sending a
set of patches where some are destined for some particular branch, you do
need to specify precisely where you want them applied. If it's not
immediately obvious, then they just aren't going to be applied, period.

> Since they are not very critical I suggest adding them to 2.6.31, but
> if you're going to push things for 2.6.30 once more then you may
> include these as well.
> 
I've rolled them in to the 2.6.30 queue now, thanks.
