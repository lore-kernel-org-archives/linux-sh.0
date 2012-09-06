From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 06 Sep 2012 05:58:02 +0000
Subject: Re: [GIT PULL] Renesas ARM-based SoC: KZM-A9-GT for 3.7 #2
Message-Id: <CACRpkdZBOjO124w3WwPpL7ekf2dU1w2HCub9EG=LUxFSPn8Ayw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1346305648-25263-1-git-send-email-horms@verge.net.au>
 <20120905224413.GC32084@quad.lixom.net>
In-Reply-To: <20120905224413.GC32084@quad.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Sep 6, 2012 at 12:44 AM, Olof Johansson <olof@lixom.net> wrote:

> So, we can't pull in this branch with its dependency without an agreement that
> Linus holds a branch stable with at least the pcf857x patch on it. Linus?

OMG! OK let's claim that it's stable now then, it's close enough
to the merge window.

Ironically his was caused by a Samsung commit (IIRC) which I
applied to the GPIO tree but shouldn't be there (instead to be
funneled through ARM SoC) so I had to take it out after
a week. So maybe we're not so good off with these mixtures
of "ARM SoC pulls GPIO" vs "ACK and push it all through ARM SoC"
hm, maybe it's just one of those things we have to live with...

Yours,
Linus Walleij
