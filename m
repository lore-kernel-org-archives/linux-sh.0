From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 19 Sep 2012 20:53:45 +0000
Subject: Re: [RFC - PATCH] base:pm: prepare driver for common clock framework
Message-Id: <201209192253.45722.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <1347661174-15404-1-git-send-email-m-karicheri2@ti.com> <201209182334.08229.rjw@sisk.pl> <3E54258959B69E4282D79E01AB1F32B7041D3326@DFLE12.ent.ti.com>
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B7041D3326@DFLE12.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chemparathy, Cyril" <cyril@ti.com>, "mturquette@linaro.org" <mturquette@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

On Wednesday, September 19, 2012, Karicheri, Muralidharan wrote:
> >> -----Original Message-----
> >> From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> >> Sent: Tuesday, September 18, 2012 5:34 PM
> >> To: Karicheri, Muralidharan
> >> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Chemparathy, Cyril;
> >> mturquette@linaro.org; Magnus Damm; Linux-sh list
> >> Subject: Re: [RFC - PATCH] base:pm: prepare driver for common clock framework
> >> 
> >> On Saturday, September 15, 2012, Murali Karicheri wrote:
> >> > As part of my work to migrate davinci SoC code to
> >> > use common clk framework, I encountered an issue with this driver
> >> > which is calling clk_enable() and clk_disable() without prepare()/
> >> > unprepare(). This change is needed to enable common clock migration
> >> > for davinci SoCs.
> >> >
> >> > Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> >> 
> >> There are other users of this code than davinci.  For example, sh
> >> and ARM/shmobile both use it.  Have you verified that your changes will
> >> work for them too?
> >> 
> Rafael,
> 
> Technically do you agree with the changes or do I need to get it reviewed
> by someone in particular?

You may ask the people on the linux-sh list to review your patch, but there's
no guarantee that anyone will have the time to do that.

> I have no way of verifying if this works for sh and
> ARM/shmobile. I have copied this RFC patch to the list showed up by
> scripts/get_maintainer.pl list.

Well, you can send whatever you like as an RFC, but if you request that the
patch be merged, it should be submitted without the "RFC" in the subject.

> Any idea how I can get this patch reviewed by
> the sh and ARM/shmobile maintainers and get it tested as well? This is
> required for DaVinci for sure unless there is an alternate way of doing this.
> Well, then that is the idea of sending an RFC patch.

The general rule is that if you want a change to be made in the core, you
have to make sure that your change won't cause problems to happen to
anyone.  If you don't do that and your change turns out to cause problems
to happen after it's been applied, it will be reverted anyway.

Thanks,
Rafael
