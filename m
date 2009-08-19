From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 Aug 2009 13:46:34 +0000
Subject: Re: [PATCH 3/3] Add FSI-AK464x sound support for ms7724se
Message-Id: <aec7e5c30908190646l1af450e8w3178683893a17437@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uiqgk59lj.wl%morimoto.kuninori@renesas.com>
	 <20090819120058.GB20227@rakim.wolfsonmicro.main>
In-Reply-To: <20090819120058.GB20227@rakim.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, linux-sh@vger.kernel.org, alsa-devel@alsa-project.org, lethal@linux-sh.org, Takashi Iwai <tiwai@suse.de>

Hi Mark,

Thanks for your feedback!

On Wed, Aug 19, 2009 at 9:00 PM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Aug 19, 2009 at 08:25:28PM +0900, Kuninori Morimoto wrote:
>> + =A0 =A0 /* enable FSI */
>> + =A0 =A0 gpio_request(GPIO_FN_FSIMCKB, =A0 =A0NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_FSIMCKA, =A0 =A0NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_FSIOASD, =A0 =A0NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_FSIIABCK, =A0 NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_FSIIALRCK, =A0NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_FSIOABCK, =A0 NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_FSIOALRCK, =A0NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_CLKAUDIOAO, NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_FSIIBSD, =A0 =A0NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_FSIOBSD, =A0 =A0NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_FSIIBBCK, =A0 NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_FSIIBLRCK, =A0NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_FSIOBBCK, =A0 NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_FSIOBLRCK, =A0NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_CLKAUDIOBO, NULL);
>> + =A0 =A0 gpio_request(GPIO_FN_FSIIASD, =A0 =A0NULL);
>
> Is this something that the FSI driver should do for itself? =A0It looks
> like there's no pin options here, just fixed functions for FSI A or B so
> replicating per-board seems redundant. =A0On the other hand, if it's
> idiomatic for SH better keep it this way.

These GPIO_FN_ values are processor specific, sh7724 in this case. I
suspect we will see the FSI block reused in future processors so
keeping processor-specific bits out of the driver itself may be a good
plan. Long term I'd be more than happy to pass along processors
specific GPIOs to each driver, but at this point I don't know any
clean and standard way to do that.

Cheers,

/ magnus
