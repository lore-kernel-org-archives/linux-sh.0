From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Thu, 12 Sep 2013 10:50:35 +0000
Subject: Re: "cpufreq: fix serialization issues with freq change notifiers" breaks cpufreq too
Message-Id: <3488595.xbBYlylYai@vostro.rjw.lan>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
 <52310E43.1090808@intel.com>
 <CAKohpomuJNQmk5fg5en5usPgipj7hzXUVNMhz1MjAS-47X4Ggg@mail.gmail.com>
In-Reply-To: <CAKohpomuJNQmk5fg5en5usPgipj7hzXUVNMhz1MjAS-47X4Ggg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday, September 12, 2013 11:06:14 AM Viresh Kumar wrote:
> On 12 September 2013 06:13, Rafael J. Wysocki
> <rafael.j.wysocki@intel.com> wrote:
> > Yes, if you can point to a specific driver having this problem.
> 
> There are so many of those (I know it because I went through almost all drivers
> recently with my cleanup series): cpufreq-cpu0, omap-cpufreq,
> exynos-cpufreq, etc..
> 
> They all do this:
> 
> A. If new freq is more than old: Increase voltage
> B. Change freq
> C. If new freq is less than old: decrease voltage

Well, if there's more than one it's even simpler.  You can just pick one. :-)

Like, "for example, <driver name> does the following ... which may cause the
hardware to misbehave, because ...".

Thanks,
Rafael

