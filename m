From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Sep 2010 08:37:12 +0000
Subject: Re: [PATCH] sh: Set CONFIG_SYSFS_DEPRECATED_V2=n
Message-Id: <20100914083712.GN7336@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <2bf9c3bb585d142503d6b7f3669e2138ba9ed112.1282398356.git.matt@console-pimps.org>
In-Reply-To: <2bf9c3bb585d142503d6b7f3669e2138ba9ed112.1282398356.git.matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Aug 22, 2010 at 07:06:01PM +0900, Paul Mundt wrote:
> On Sat, Aug 21, 2010 at 03:13:44PM +0100, Matt Fleming wrote:
> > On Sat, Aug 21, 2010 at 02:47:59PM +0100, Matt Fleming wrote:
> > > As the help for the config option suggests, this option really shouldn't
> > > be set by default for any recent distribution as it changes the layout
> > > of sysfs. I spotted this while running debian when udev got very
> > > confused by the sysfs layout and failed to create some device nodes.
> > > 
> > > Signed-off-by: Matt Fleming <matt@console-pimps.org>
> > > ---
> > >  arch/sh/configs/sh7785lcr_defconfig |    1 -
> > >  1 files changed, 0 insertions(+), 1 deletions(-)
> > 
> > Hmm.. on second thought, this option should probably be removed from all
> > the defconfigs in arch/sh/configs as it defaults to 'n' in
> > init/Kconfig. Unless anyone knows of a specific reason to leave it
> > enabled for a particular board?
> 
> No, the only reason it is still enabled for some boards is because people
> rarely if ever send defconfigs updates that actually match the configs
> being regularly used. Killing it off uniformly is fine.

Ok, I actually forgot to apply this, so it's applied now. Hopefully that
will be the end of that!
