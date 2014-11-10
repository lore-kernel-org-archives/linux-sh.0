From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2014 09:54:21 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g legacy: Add LED support
Message-Id: <CAMuHMdXB94yqw-aVLC+JjicYk157bdFFM5VaxzNdnC_Z+N5xuQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415278255-2047-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415278255-2047-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Fri, Nov 7, 2014 at 5:14 AM, Simon Horman <horms@verge.net.au> wrote:
> I'm not sure of the motivation for this but in general I'm not

It allowed me to find a bug in core code ;-)

> accepting nay new platform device code for shmobile.

Fair enough.

Just drop any patches adding more legacy platform support.
People who're interested in them can still pick them up from the mailing list.

> On Thu, Nov 06, 2014 at 01:50:55PM +0100, Geert Uytterhoeven wrote:
>> Add support for the 4 GPIO-controlled LEDs on the kzm9g development
>> board.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  arch/arm/mach-shmobile/board-kzm9g.c | 39 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
