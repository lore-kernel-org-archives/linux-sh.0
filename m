From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2014 09:24:38 +0000
Subject: Re: [PATCH 03/03] ARM: shmobile: mackerel: Remove legacy board support
Message-Id: <CAMuHMdV3WvJrGRNtjkUM6DhwEff2jARoXrMXRrEUb5xUaPNFDg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141029074717.405.8623.sendpatchset@w520>
In-Reply-To: <20141029074717.405.8623.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Wed, Oct 29, 2014 at 10:13 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> I do think
> we can ditch the bindings since we phase out the board support, but
> perhaps that's wrong. =)

The DTS only contains the memory node, which we can easily resurrect,
if needed.

> Do you think it is good timing to get rid of Mackerel now, or do you
> prefer to wait?

I think the Mackerel-specific code can go.

The sh7372 SoC code is still there. That contains some still interesting parts
(cpuidle and wake-up source code). If they can stay for a little
while, I'm happy.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
