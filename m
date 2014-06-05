From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Jun 2014 06:05:57 +0000
Subject: Re: [alsa-devel] r8a7790 only has audio when clock is forced on
Message-Id: <87zjhrj3gc.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <538E0487.1010700@codethink.co.uk>
	<20140603214226.GA2520@sirena.org.uk>
	<87egz5ldtm.wl%kuninori.morimoto.gx@renesas.com>
	<538EE0BE.5030304@codethink.co.uk>
In-Reply-To: <538EE0BE.5030304@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@lists.codethink.co.uk, Violeta Menendez Gonzalez <violeta.menendez@codethink.co.uk>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, linux-sh@vger.kernel.org


Hi Ben

# I misunderstood your point...

> The result of our investigation is as follows:
> 
> - The clock code correctly enables SSI(ALL) but the audio does not work
> - If we force SSI(ALL) to be on all the time, we have working audio

SSI(ALL) bit mean "this bit is always required for all SSI"
If you want to use SSI0, then, you need to enable "SSI(ALL) + SSI0" bit

