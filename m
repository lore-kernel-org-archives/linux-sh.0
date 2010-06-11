From: john stultz <johnstul@us.ibm.com>
Date: Fri, 11 Jun 2010 03:03:39 +0000
Subject: Re: [PATCH v2] sh_tmu: compute mult and shift before registration
Message-Id: <1276225419.16089.90.camel@work-vm>
List-Id: <linux-sh.vger.kernel.org>
References: <1275342348-22499-1-git-send-email-aurelien@aurel32.net>
In-Reply-To: <1275342348-22499-1-git-send-email-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 2010-06-10 at 12:27 -0700, john stultz wrote:
> On Thu, 2010-06-10 at 15:20 +0900, Magnus Damm wrote:
> > On Tue, Jun 8, 2010 at 4:28 AM, john stultz <johnstul@us.ibm.com> wrote:
> > > Does that sound reasonable?
> > 
> > I think so. So like I mentioned earlier, we don't know what frequency
> > range is suitable at clock source registration time. So from that
> > point of view I can't really see why we should keep the
> > clocksource_register_hz()/khz() functions. Updating the frequency in
> > the ->enable() callback and using clocksource_register() sounds simple
> > and straightforward to me. Ideally I'd like to avoid setting up the
> > mult and shift values before registration and instead put all logic in
> > the ->enable() callback.
> > 
> > The ->enable() callback is optional so we will have to deal with
> > clocksources without ->enable() callbacks. This should be trivial -
> > such drivers can manually setup shift/mult or call
> > __clocksource_update_freq() before clocksource_register().
> 
> Why not instead register the tmu clocksource with a dummy freq initially
> and then update it in ->enable()?
> 
> I'd just prefer to not complicate the majority of clocksources just to
> handle the few (2) cases where we don't know the frequency at
> registration time.

So I took a rough shot at this. Would you mind checking it out and
seeing if its sufficient?

Its my first two patches from the conversion patchset here:
http://sr71.net/~jstultz/timekeeping/clocksourceregister_hz/patches/

Specifically: 
http://sr71.net/~jstultz/timekeeping/clocksourceregister_hz/patches/0001-Add-__clocksource_updatefreq_hz-khz-methods.patch
http://sr71.net/~jstultz/timekeeping/clocksourceregister_hz/patches/0002-Convert-sh_tmu-sh_cmt-clocksources-to-clocksource_re.patch


Let me know if there's anything I'm missing.

thanks
-john

