From: Kevin Hilman <khilman@ti.com>
Date: Mon, 16 May 2011 10:07:39 +0000
Subject: Re: [PATCH 6/6][RFC] PM / Domains: Support for multiple generic power domain states
Message-Id: <87sjsfdklw.fsf@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201104290154.12966.rjw@sisk.pl> <201105082320.57185.rjw@sisk.pl>
	<201105160117.46927.rjw@sisk.pl> <201105160138.10431.rjw@sisk.pl>
In-Reply-To: <201105160138.10431.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Mon, 16 May 2011 01:38:10 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, MyungJoo Ham <myungjoo.ham@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Alan Stern <stern@rowland.harvard.edu>

Hi Rafael,

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Allow the generic power domains support code to handle power
> domains with multiple states.  

Thanks!

Before I even had the time to respond to you about my previous request
for this kind of feature, you've already implmented it. :)  

> Replace the .power_down_ok()
> callback in struct dev_power_governor with a new callback
> .choose_state() that will return the number of the state to put the
> power domain into.  Add new fields nr_states and current_state to
> struct generic_power_domain with the assumption that state 0 will be
> the full power state and states 1 through (nr_states - 1) will be low
> power.  
> Replace power domain callbacks .power_off() and .power_on()
> with a single .set_state() callback taking the number of the state
> to put the power domain into as its second argument.  Add a new
> generic power domain callback .power_off_state() (taking a state
> number as its second argument) allowing the core to check if
> device runtime PM callbacks need to be executed before putting the
> given power domain into the given state.  Modify the core power
> domains code and the ARM shmobile platform code to take all of the
> above changes into account.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Reviewed-by: Kevin Hilman <khilman@ti.com>

This looks like a better starting point for more complicated hardware.

Thanks,

Kevin
