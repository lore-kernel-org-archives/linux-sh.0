From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Nov 2013 19:34:34 +0000
Subject: Re: [PATCH v2 01/03] clocksource: Add Kconfig entries for CMT, MTU2, TMU and STI
Message-Id: <201311202034.34384.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20131106110508.6806.48070.sendpatchset@w520> <201311141340.38208.arnd@arndb.de> <528D001C.9010009@linaro.org>
In-Reply-To: <528D001C.9010009@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Stultz <john.stultz@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, khilman@linaro.org, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms@verge.net.au, olof@lixom.net, Thomas Gleixner <tglx@linutronix.de>

On Wednesday 20 November 2013, John Stultz wrote:
> On 11/14/2013 04:40 AM, Arnd Bergmann wrote:
> 
> Sorry, somehow this mail slipped by me.
> 
> So yea, as I mentioned earlier, the build testing is the one thing I
> don't have a good argument against. But I still would rather not having
> user prompts for these sorts of things.
> 
> Even so, it seems to me that it would be better to still avoid prompting
> the user for the build test and instead just always build the drivers if
> BUILD_TEST is enabled.
> 
> Is the driver by driver fine-granularity for build testing actually
> worth having all the module prompts?  Or could we coarsen it a bit, and
> have BUILT_TEST_TOPIC, so under kernel hacking or something you can
> enable build testing and select the categories of items you want to
> build (rather then having to go through them one by one?)

I would much prefer keeping things consistent across subsystems, which
means one symbol with prompt per driver. The only technical argument for
this is that it lets you disable some drivers when they do break in a
randconfig or allmodconfig build.

	Arnd
