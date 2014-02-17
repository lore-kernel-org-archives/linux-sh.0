From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 17 Feb 2014 01:36:25 +0000
Subject: Re: [PATCH 02/03] ARM: shmobile: Remove KZM9D board code
Message-Id: <CANqRtoRrm12Fb1gxHKCSi=MzywvdcoPPpCESsff6BofPwuSvCw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140213082558.30630.93034.sendpatchset@w520>
 <20140213082618.30630.64196.sendpatchset@w520>
 <20140217000202.GA18898@verge.net.au>
In-Reply-To: <20140217000202.GA18898@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Mon, Feb 17, 2014 at 9:02 AM, Simon Horman <horms@verge.net.au> wrote:
> Hi Magnus,
>
> I'm not clear on the motivation for removing emev2_smp_ops from
> emev2.h only to have to add it as an extern to setup-emev2.c.
> But if thats how you like to roll then I have no objections.

Hehe, I suppose I felt a sudden urge to remove that particular header file.

> However, what I would like to ask is that the emev2.h shuffling,
> that is the changes to emev2.h, setup-emev2.c and smp-emev2.c
> could be moved into a follow-up patch that I will queue up at a later date.

That's fine.

> The reason is that these really seem to be SoC changes but
> the main portion of this patch is a board change. And as you
> know the arm-soc people like soc and board changes split into
> different branches.

Sure. Would you like me to redo 2/3 to break out the header file bits?

Thanks,

/ magnus
