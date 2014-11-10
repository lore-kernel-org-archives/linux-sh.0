From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2014 08:03:23 +0000
Subject: Re: [PATCH v3/resend] ARM: shmobile: Add early debugging support using SCIF(A)
Message-Id: <CAMuHMdUcZYTz4uLn4G9CECT5ZuKtHJuDZzR0WrzR3oo8qD3cfA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415273910-32356-1-git-send-email-geert+renesas@glider.be>
 <3499638.LG41cHl0JS@wuerfel>
 <CAMuHMdUU7XK57a70HWP0+nfwaZ-sXQ5EC2CShgmxwx6JKnuyPQ@mail.gmail.com>
 <20777697.th35W64j5e@wuerfel> <20141110005944.GE16836@verge.net.au>
In-Reply-To: <20141110005944.GE16836@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 10, 2014 at 1:59 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Nov 06, 2014 at 02:26:45PM +0100, Arnd Bergmann wrote:
>> On Thursday 06 November 2014 13:33:58 Geert Uytterhoeven wrote:
>> > On Thu, Nov 6, 2014 at 12:53 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > > On Thursday 06 November 2014 12:38:30 Geert Uytterhoeven wrote:
>> > >> Add serial port debug macros for the SCIF(A) serial ports.
>> > >> This includes all shmobile SoCs, except for EMEV2.
>> >
>> > > I don't object to this patch going in, but have you looked at doing
>> > > just earlycon instead? We are still missing some fixmap changes

> This patch feels like is is ready for me to queue up.
> Is that the consensus here?

Please wait for v3, which will get rid of the multi-level choice statements,
as requested by Arnd.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
