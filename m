From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 05 May 2015 17:13:04 +0000
Subject: Re: [PATCH v2 01/15] pinctrl: sh-pfc: Add r8a7793 PFC support part 1: pinmux data
Message-Id: <CAO3366yQxGAKZOt1Sgj-ansoiT6DXhiRs_xG84x-0S6jGkiYkQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430403544-26742-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1430403544-26742-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 5, 2015 at 11:07 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> After compensating for that, pfc-r8a7793.c is identical to pfc-r8a7791.c.

Um... D'oh! :(
[Wouldn't it be Sergei's job to point out something like that?]

> So I think we should use a single file for both, or at least share (most of )
> the data structures (sh_pfc_soc_info contains the SoC name, so it can't
> be shared).

Yes, absolutely.

> BTW, it's my understanding M2-W and M2-N are identical, except for the
> wide/double vs. narrow/single memory channels, which doesn't impact
> configurable pins. Please correct me if I'm wrong.

As far as pin control is concerned, the differences between M2-W and
M2-N that I could find are:

1. The initial value of GPSR6 is 0x40000000 for M2-W and 0x04000000
for M2-N.  Might well be an error in the documentation, though.
2. On M2-N, the DDR3-related registers exist, but are ignored.

Neither should keep us from using the same code on both.

CU
Uli
