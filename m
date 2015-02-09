From: Manuel Lauss <manuel.lauss@gmail.com>
Date: Mon, 09 Feb 2015 09:04:04 +0000
Subject: Re: [alsa-devel] Can we remove un-used Sound driver ?
Message-Id: <CAOLZvyHYaEEPnmkjZDX=Ej+9UcfXZz8tK+Yv9T96_u69K9ky-A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87egq7774l.wl%kuninori.morimoto.gx@renesas.com>
 <87a90sj0hy.wl%kuninori.morimoto.gx@renesas.com> <20150205180343.GB21293@sirena.org.uk>
 <CAOLZvyGemO=O8Eqafj0KUXg7cELtREcARU5KFDieAr3Y9DdVnw@mail.gmail.com> <87k2zrx51v.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k2zrx51v.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Mon, Feb 9, 2015 at 2:10 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Manuel, Mark
>
>> >> I'm very sad, but...
>> >> Good bye sh7760
>> >> Good bye ssi
>> >> Good bye hac
>>
>> I still have working hardware for those 3 files, I just need to dust
>> it off.  But the last time I checked (~3 years ago) I had no issues
>> with sound.
>
> I didn't know that there is user of these drivers...
> On which board ?

It's a custom SH7760-based module system. Probably only 1000 or so exist :)
I have no problem caring for these sound drivers outside the main kernel, I've
been forward porting the kernel patch for this board system since 2005.

Delete them if you wish, there probably won't be any in-tree users for them
ever.

Manuel
