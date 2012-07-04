From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 04 Jul 2012 10:55:57 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <201207041255.58069.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday, July 04, 2012, Mark Brown wrote:
> On Wed, Jul 04, 2012 at 12:40:56PM +0200, Rafael J. Wysocki wrote:
> 
> > Well, if arch-wide, then perhaps we don't need REGULATOR_FIXED_VOLTAGE at all
> > and we can just make things depending on it depend on REGULATOR directly?
> 
> > The meaning of what you're proposing above is pretty much
> > "REGULATOR_FIXED_VOLTAGE should be set whenever REGULATOR is" and I guess
> > REGULATOR_FIXED_VOLTAGE depends on REGULATOR, so they appear to be equivalent.
> 
> > How much code does really depend on REGULATOR_FIXED_VOLTAGE which is not build
> > when REGULATOR is set?
> 
> No, that won't help - the problem is that we want a specific regulator
> driver to be built in order to ensure that the services it provides are
> available.

OK, so if each board requires a specific regulator driver to be used, then
I think we should just select it from arch/arm/mach-shmobile/Kconfig for
that particular board.

Thanks,
Rafael
