From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 12 Sep 2013 05:48:14 +0000
Subject: Re: "cpufreq: fix serialization issues with freq change notifiers" breaks cpufreq too
Message-Id: <CAKohpomuJNQmk5fg5en5usPgipj7hzXUVNMhz1MjAS-47X4Ggg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
 <2703632.ul5ekQh5oq@vostro.rjw.lan>
 <CAKohpo=RKB-_EO=cjaOorAfN=y_cMgJg-j6=xtX71a-TwujgsA@mail.gmail.com>
 <2013615.oHjWkmedue@vostro.rjw.lan>
 <CAKohpokEZcwF-zL6rTXYyC_x=SJzGFvdvxqvmvyhJHa8nPXogQ@mail.gmail.com>
 <52310E43.1090808@intel.com>
In-Reply-To: <52310E43.1090808@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 12 September 2013 06:13, Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
> Yes, if you can point to a specific driver having this problem.

There are so many of those (I know it because I went through almost all drivers
recently with my cleanup series): cpufreq-cpu0, omap-cpufreq,
exynos-cpufreq, etc..

They all do this:

A. If new freq is more than old: Increase voltage
B. Change freq
C. If new freq is less than old: decrease voltage
