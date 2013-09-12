From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 12 Sep 2013 10:52:33 +0000
Subject: Re: "cpufreq: fix serialization issues with freq change notifiers" breaks cpufreq too
Message-Id: <CAKohpo=gF7pVYXrDxBxMOvpu96VOB2V00Y6HACCEz=X-7jWj4A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
 <52310E43.1090808@intel.com>
 <CAKohpomuJNQmk5fg5en5usPgipj7hzXUVNMhz1MjAS-47X4Ggg@mail.gmail.com>
 <3488595.xbBYlylYai@vostro.rjw.lan>
In-Reply-To: <3488595.xbBYlylYai@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 12 September 2013 16:31, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Well, if there's more than one it's even simpler.  You can just pick one. :-)
>
> Like, "for example, <driver name> does the following ... which may cause the
> hardware to misbehave, because ...".

:)

I have written one of my longest changelog ever on the resent of this patch..
Hope that doesn't have any unanswered stuff left :)
