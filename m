From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Aug 2013 07:12:09 +0000
Subject: Re: EMEV2: I2C and SPI
Message-Id: <CANqRtoTsiXhKN=85kbXqpGToDb-_hug_wO_jOyNgLk+K5ykdzg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5208C796.2050500@codethink.co.uk>
In-Reply-To: <5208C796.2050500@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ian,

On Mon, Aug 12, 2013 at 8:31 PM, Ian Molton <ian.molton@codethink.co.uk> wrote:
> Hi guys,
>
> I've got SPI and I2C drivers for the emev2.

That sounds nice.

> Right now, however they depend on Ben Dooks' clock patchset.

Ok. I (and perhaps other people) need to pick that up and see how to
proceed from here.

> Are there plans to merge it, and when should I post my patches? Who is
> working on emev2 that might be worth CCing too?

I think you should post your code as early as possible. Individual
drivers can be merged independently of SoC code (including clock
stuff) so I suggest that you just post your drivers and work on
getting them merged.

> I'd like to get these two drivers mainstreamed ASAP :)

Good plan!

/ magnus
