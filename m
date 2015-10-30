From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2015 08:04:03 +0000
Subject: Re: [PATCH] i2c: rcar: call rcar_i2c_init() after pm_runtime_get_sync()
Message-Id: <CAMuHMdW7s3j97sdhgUC5hU++FvOn1U5627e3+RouEAKNUAZsDQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87oafiyq8y.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdXnMFh5umv=wJdvrcMip+DOn8rYP_3eUTufFw4q2Sr8Jw@mail.gmail.com>
	<87h9l9gquz.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87h9l9gquz.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Morimoto-san,

On Fri, Oct 30, 2015 at 1:13 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> >
>> > rcar_i2c_init() initializes I2C device, but it should be called
>> > *after* pm_runtime_get_sync(). Otherwise it outputs very hi speed
>> > clock. This patch solved this issue,
>> > This patch also removes pointless rcar_i2c_init()
>> > from rcar_i2c_probe()
>> >
>> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> > ---
>> >  drivers/i2c/busses/i2c-rcar.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
>> > index 616433d..edbfefc 100644
>> > --- a/drivers/i2c/busses/i2c-rcar.c
>> > +++ b/drivers/i2c/busses/i2c-rcar.c
>> > @@ -474,6 +474,8 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
>> >
>> >         pm_runtime_get_sync(dev);
>> >
>> > +       rcar_i2c_init(priv);
>>
>> Hence now it's done again for every transfer?
>>
>> What about moving it just before the call to i2c_add_numbered_adapter(),
>> and wrapping it inside pm_runtime_get_sync(dev)/pm_runtime_put()?
>
> In my experience, it should be called again for every transfer.
> Because SoC/IP might doesn't keep register setting value if you call pm_runtime_put()
> (I fought with this behavior when sh_mobile IP :P )

At least for R-Car Gen1 and Gen2, the datasheet states that register values
are retained during sleep or module standby. I can't seem to find information
about this for Gen3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
