From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 04 Jul 2012 10:40:56 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <201207041240.56586.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday, July 04, 2012, Guennadi Liakhovetski wrote:
> Paul, Magnus, Rafael
> 
> What do you think about this? Shall we force the fixed regulator globally 
> on for sh and sh-mobile, shall we only force it on for affected boards, or 
> shall we leave it to the user to shoot themselves in the foot? In general 
> we're not trying to force all Kconfig options on, that a board needs. 
> There are enough ways to have a non-working configuration. E.g., you can 
> leave off the sh I2C driver. Arguably, having to enable the fixed voltage 
> regulator is less obvious, than needing a correct I2C bus driver.
> 
> I think I would go with
> 
> 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
> 
> - ideally on a per-board basis, or arch-wide. Mark doesn't favour at least 
> the latter of these options, IIUC. So, maybe adding entries to defconfigs 
> would indeed sufice for now (but no dummy regulator!)

Well, if arch-wide, then perhaps we don't need REGULATOR_FIXED_VOLTAGE at all
and we can just make things depending on it depend on REGULATOR directly?

The meaning of what you're proposing above is pretty much
"REGULATOR_FIXED_VOLTAGE should be set whenever REGULATOR is" and I guess
REGULATOR_FIXED_VOLTAGE depends on REGULATOR, so they appear to be equivalent.

How much code does really depend on REGULATOR_FIXED_VOLTAGE which is not build
when REGULATOR is set?

Thanks,
Rafael
