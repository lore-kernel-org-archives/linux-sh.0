From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 16 Feb 2014 10:25:37 +0000
Subject: Re: [PATCH 3/6] i2c: rcar: do not print error if device nacks transfer
Message-Id: <CAMuHMdXKPFpMZeN9wPmBQEuDGxLHGkGmwsfMDWZr5FUbVHt+Qw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390752337-22386-1-git-send-email-ben.dooks@codethink.co.uk>
	<1390752337-22386-4-git-send-email-ben.dooks@codethink.co.uk>
	<20140216094655.GA2644@katana>
In-Reply-To: <20140216094655.GA2644@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk, Simon Horman <horms+renesas@verge.net.au>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Sun, Feb 16, 2014 at 10:46 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Sun, Jan 26, 2014 at 04:05:34PM +0000, Ben Dooks wrote:
>> The i2c-rcar driver currently prints an error message if the master_xfer
>> callback fails. However if the bus is being probed then lots of NAKs
>> will be generated, causing the output of a number of errors printed.
>>
>> To solve this, disable the print if the error is not -EREMOTEIO.
>>
>> An example of running i2cdetect:
>
> So, after this patch i2cdetect runs fine for you? I assume you are
> working with the lager/r8a7790 board? With koelsch/r8a7791, it stalls
> the bus :(

Do you know at which i2c client device it stalls?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
