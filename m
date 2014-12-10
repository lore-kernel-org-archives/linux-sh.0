From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Wed, 10 Dec 2014 14:44:31 +0000
Subject: Re: [PATCH] [RFC] ARM: shmobile: sh73a0 dtsi: Add Cortex-A9 TWD node
Message-Id: <CAO3366zHStXk9Py357zAkEuVZGxZWgrEgMo1cD6h_UTsCHqUKA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417617454-14533-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdX5i8qXdVUYMi+BLEe7Ah+_hJOEputW7jw5xvQ6UqH3EA@mail.gmail.com>
In-Reply-To: <CAMuHMdX5i8qXdVUYMi+BLEe7Ah+_hJOEputW7jw5xvQ6UqH3EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Dec 10, 2014 at 2:28 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Dec 3, 2014 at 3:37 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> FIXME The clock should be the PERIPH clock, but the sh73a0 CPG driver
>>       doesn't have support for that clock yet. Hence we use the ZG
>>       clock, which runs at the same frequency.
>
> It looks like we do have the clock in sh73a0.dtsi, but it's called "twd_clk".
> Ulrich, is that correct?

I believe so.

> Note that the frequency is off by a factor of 2, just like for its parent "z".
> (that is, without your (~private) patch to take into account ZSEL).

Oh. Yes. That thing. :) One moment, please...

CU
Uli
