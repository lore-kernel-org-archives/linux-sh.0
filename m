From: Chris Ball <cjb@laptop.org>
Date: Tue, 10 Jul 2012 07:19:00 +0000
Subject: Re: Boot regression on Mackerel with current mainline
Message-Id: <87r4skqe1n.fsf@octavius.laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201207031218.24797.rjw@sisk.pl>
	<Pine.LNX.4.64.1207031336320.29890@axis700.grange>
	<201207031910.24864.rjw@sisk.pl>
	<Pine.LNX.4.64.1207041125330.21042@axis700.grange>
	<87ipdws1mc.fsf@octavius.laptop.org>
	<Pine.LNX.4.64.1207100845130.29825@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1207100845130.29825@axis700.grange> (Guennadi
	Liakhovetski's message of "Tue, 10 Jul 2012 08:49:37 +0200 (CEST)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Thomas Gleixner <tglx@linutronix.de>

Hi Guennadi,

On Tue, Jul 10 2012, Guennadi Liakhovetski wrote:
>> > The latter one looks big because of a rename, but with "-M" it's pretty 
>> > trivial. Chris, do you agree?
>> 
>> Is the minimal fix to just add "| IRQF_ONESHOT" to the request_threaded_irq
>> argument?  If so, I'd rather push just that for 3.5, and I can take care of
>> having that change appear simultaneously in linux-next so that there aren't
>> any conflicts.  Is that okay with you?
>
> For that you'd have to rebase -next, right? you'd like to do that?

Yeah, I'm willing to rebase mmc-next for this -- I'd rather send the
simplest possible fix this late in 3.5-rc, and the rebase is simple.
Also, this fix is logically distinct from your rename patch.

I don't think I need you to send anything more, I'll add the initial
patch adding "| IRQF_ONESHOT", rebase your "extend and rename" patch on
top of that, push both to mmc-next, and then send the initial patch to
Linus in a few days.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
