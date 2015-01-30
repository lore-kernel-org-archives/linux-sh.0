From: Simon Horman <horms@verge.net.au>
Date: Fri, 30 Jan 2015 00:43:37 +0000
Subject: Re: [PATCH v2] ARM: shmobile: r8a73a4: Instantiate GIC from C board code in legacy builds
Message-Id: <20150130004337.GA5964@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150128124645.21199.99590.sendpatchset@little-apple>
In-Reply-To: <20150128124645.21199.99590.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 29, 2015 at 03:42:29PM +0900, Simon Horman wrote:
> On Thu, Jan 29, 2015 at 09:49:19AM +0900, Simon Horman wrote:
> > On Thu, Jan 29, 2015 at 09:35:43AM +0900, Simon Horman wrote:
> > > On Wed, Jan 28, 2015 at 02:34:43PM +0100, Geert Uytterhoeven wrote:
> > > > Hi Magnus,
> > > > 
> > > > On Wed, Jan 28, 2015 at 1:46 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > > > > From: Magnus Damm <damm+renesas@opensource.se>
> > > > >
> > > > > As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
> > > > > domain."), the APE6EVM legacy board support is known to be broken.
> > > > >
> > > > > The IRQ numbers of the GIC are now virtual, and no longer match the
> > > > > hardcoded hardware IRQ numbers in the legacy platform board code.
> > > > >
> > > > > To fix this issue specific to non-muliplatform r8a73a4 and APE6EVM:
> > > > >  1) Instantiate the GIC from platform board code and also
> > > > >  2) Skip over the DT arch timer as well as
> > > > >  3) Force delay setup based on DT CPU frequency
> > > > >
> > > > > With these 3 fixes in place interrupts on APE6EVM are now unbroken.
> > > > >
> > > > > Partially based on legacy GIC fix by Geert Uytterhoeven, thanks to
> > > > > him for the initial work.
> > > > >
> > > > > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> > > > 
> > > > Thanks!
> > > > 
> > > > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > 
> > > Thanks, I have queued this up as a fix for v3.19.
> > 
> > Actually, perhaps I spoke a little soon there.
> > 
> > Although things seem a bit better booting ape6evm_defconfig still
> > doesn't make it to userspace.
> > 
> > The bootlog is for renesas-next-20150126-v3.19-rc1 with your patch applied.
> > A similar result seems to occur using v3.19-rc6 with your patch applied.
> 
> As discussed with Magnus on IRC this seems to be a separate issue:
> which I am yet to have any luck bisecting.
> 
> So regardless of this issue I will queue this patch up as it seems to be a
> valid fix for v3.19.

To clarify:

With this patch queued up the ape6evm now boots to a prompt using
the ape6evm_defconfig with the following modifications:

* Disabling CONFIG_BLOCK
* Disabling CONFIG_NET
* Enabling initrd (as NFS user-space is no longer possible due to the above)

When booting such a configuration a long delay occurs after initialising
the SDHI devices. This delay can be avoided by:

* Disabling CONFIG_REGULATOR

With Magnus's patch things are better but we still have a partial
regression.

Given that we are working towards removing support for booting the ape6evm
using legacy C and that the reason that the above configuration is needed
to get to user-space is not know (at least to me) it seems unlikely to me
that this problem or problems will receive more attention.

The purpose of this email is to document the above.

I would like to thank Magnus for the time he has spent on this problem for
this and other SoCs. And the time he spent working with my to try to get
the ape6evm in better shape; an effort that appears to have been in vain.
