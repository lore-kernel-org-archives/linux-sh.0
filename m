From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2014 08:21:12 +0000
Subject: Re: regulator node names and unit-addresses? (Re: [PATCH v2 1/5] ARM: shmobile: kzm9d: Remove spurio
Message-Id: <CAMuHMdWQfSLwqMMigLOZuGFJqQO03Qyw+ZHE1YAgd6mNDGmrEg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdVC2h4_Q+4BpV5iLbhfviimzrnfZ3+c6dqnegTAxBHw_g@mail.gmail.com>
 <20140924081455.GU4015@sirena.org.uk>
In-Reply-To: <20140924081455.GU4015@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Mark,

On Wed, Sep 24, 2014 at 10:14 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Sep 24, 2014 at 09:02:23AM +0200, Geert Uytterhoeven wrote:
>> On Wed, Sep 24, 2014 at 3:13 AM, Simon Horman <horms@verge.net.au> wrote:
>
>> > What should we call the nodes?
>
>> "regulator0" and "regulator1"?
>> "regulator1v8" and "regulator3v3"?
>
>> Documentation/devicetree/bindings/regulator/regulator.txt doesn't mention
>> node names or (presence/lack of) unit-adresses, but the examples do have
>> unit-addresses.
>
>> Is this another case where we don't follow the "no reg, no unit-address"
>> ePAPR rule?
>
> As far as the regulator API is concerned the node name is completly
> immaterial and all this stuff is just verbiage we're forced to include.
> As far as I can tell the requirement that node names be in the form
> "regulator" or whatever is just another thing that wasn't terribly well
> thought through in ePAPR, they were trying to do classes I think.

So perhaps we should just keep "regulator@0" and "regulator@1"?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
