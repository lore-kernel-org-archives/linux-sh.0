From: Borislav Petkov <bp@alien8.de>
Date: Thu, 30 Jul 2015 10:59:17 +0000
Subject: Re: [PATCH] bus: subsys: update return type of ->remove_dev() to void
Message-Id: <20150730105917.GA25460@nazgul.tnic>
List-Id: <linux-sh.vger.kernel.org>
References: <02c0569741812b655edde5124c3e2937bb79f9f8.1438248445.git.viresh.kumar@linaro.org>
In-Reply-To: <02c0569741812b655edde5124c3e2937bb79f9f8.1438248445.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rjw@rjwysocki.net>, Chris Metcalf <cmetcalf@ezchip.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Joe Perches <joe@perches.com>, Joerg Roedel <jroedel@suse.de>, open list <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, Nicolas Iooss <nicolas.iooss_linux@m4x.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Thomas Gleixner <tglx@linutronix.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>

On Thu, Jul 30, 2015 at 03:04:01PM +0530, Viresh Kumar wrote:
> Its return value is not used by the subsys core and nothing meaningful
> can be done with it, even if we want to use it. The subsys device is
> anyway getting removed.

I'm assuming sysfs paths covered by it, will remain intact... ? For the
microcode loader case that's this hierarchy here:

$ tree /sys/devices/system/cpu/cpu?/microcode/
/sys/devices/system/cpu/cpu0/microcode/
├── processor_flags
└── version
/sys/devices/system/cpu/cpu1/microcode/
├── processor_flags
└── version
...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
