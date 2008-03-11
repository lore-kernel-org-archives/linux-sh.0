From: "Jeongdo Son" <sohn9086@gmail.com>
Date: Tue, 11 Mar 2008 04:21:37 +0000
Subject: Re: Is SH7727 supported by linux?
Message-Id: <59fd4ce80803102121x26ca2e33g2b708436c9b71a01@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <59fd4ce80803100159o6c178fdajefa5ffdc2a8b811a@mail.gmail.com>
In-Reply-To: <59fd4ce80803100159o6c178fdajefa5ffdc2a8b811a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Paul

Thanks for your comment.
Yeah, adding SH7727 seems to be not so difficult.
Now I think I can move on to the next step.

Best regards,
Jeongdo Son

On Tue, Mar 11, 2008 at 12:36 PM, Paul Mundt <paul.mundt@renesas.com> wrote:
> On Mon, Mar 10, 2008 at 05:59:05PM +0900, Jeongdo Son wrote:
>  > I'm planning to port linux on a SH7727 based board,
>  > but I couldn't find CPU_SUBTYPE_SH7727 from arch/sh/Kconfig.
>  > Is SH7727 supported?
>  >
>  SH7727 is an ancient SH3-DSP. You can poke around arch/sh/Kconfig for
>  subtypes that select CPU_SH3 && CPU_HAS_DSP to find a starting point.
>  Presently this includes SH7710/SH7712/SH7720/SH7721. Adding SH7727 should
>  be trivial, just follow the existing conventions for those parts. A lot
>  of the old SH3/SH3-DSP variants are also completely compatible with each
>  other (pin and otherwise), so you may always want to make sure that it's
>  not already supported under a different subtype qualifier.
>
