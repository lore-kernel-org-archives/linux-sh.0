From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Jun 2014 17:08:34 +0000
Subject: Re: [alsa-devel] "ak" vs "asahi-kasei" (was: Re: [PATCH 3/3 v3] ARM: shmobile: lager: add sound supp
Message-Id: <CAMuHMdUYFdbOxyqZnPAUxfY1vkqDr-7RUJmqgivuMQugyMme7g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWTVBjFzA9L9Eqpq_2Xi9_NHkOCLrb_UjK611SBfwnc=Q@mail.gmail.com>
	<87ioo7c0g5.wl%kuninori.morimoto.gx@renesas.com>
	<539815E6.2050304@codethink.co.uk>
	<20140611165410.GK5099@sirena.org.uk>
	<CAMuHMdUT0hEBGbN+W-Oz5zJ0N8S2VDMndqtDO=EtWF3jG2MEew@mail.gmail.com>
	<20140611170233.GL5099@sirena.org.uk>
In-Reply-To: <20140611170233.GL5099@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Mark Brown <broonie@kernel.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

On Wed, Jun 11, 2014 at 7:02 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jun 11, 2014 at 06:57:44PM +0200, Geert Uytterhoeven wrote:
>> On Wed, Jun 11, 2014 at 6:54 PM, Mark Brown <broonie@kernel.org> wrote:
>> > They're usually referred to as AKM when abbreviated and their web site
>> > is http://www.akm.com/ - don't know what the stock ticker symbol is.  In
>> > any case there's no real cost to adding both abbreviated and
>> > non-abbreviated forms if we want to transition.
>
>>     of: Add vendor prefix for Asahi Kasei Corp.
>
>>     Their stock ticker is 3407.T which wouldn't make a good DT vendor
>>     prefix. Use the company name initials instead.
>
> Sounds like akm, is a better bet then, especially as ak, has no real
> adoption.

Except for Автомат Калашникова...

> I think the bikeshed would be much better painted pink with yellow spots :)

Definitely.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
