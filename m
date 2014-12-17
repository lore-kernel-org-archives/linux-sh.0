From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Dec 2014 01:23:39 +0000
Subject: Re: [PATCH v2 0/7] ARM: shmobile: ape6evm: multiplatform support
Message-Id: <CANqRtoReend1FmC2QOWD3666t=meVtaBUhaenhTk_OLvYpQvCQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418747163-21729-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1418747163-21729-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich and Simon,

On Wed, Dec 17, 2014 at 1:25 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Hi!
>
> This series implements multiplatform support for the APE6EVM board, and
> eliminates both legacy platforms.
>
> This version incorporates the "ARM: shmobile: ape6evm-reference: add missing
> devices" series.  As suggested by Magnus, it synchronizes the ape6evm and
> ape6evm-reference dts files first, eliminating the big renaming at the end.

Thanks for resending following this style. It is easy to understand -
at least for me!

> It is split in such a way that the first five patches can be merged without
> breaking either of the two legacy platforms.  Simon, please pick those up.
> (Or the first three, if adding a multiplatform target that does not build is
> a problem.) Thank you.

The first patch seems to have some issue reported by Laurent. It needs
to be reworked.

Patch 2-5 should be possible to merge as-is unless I'm mistaken.

Simon, if you don't mind, can you please consider picking up 2-5 before 1, 6-7?

As for patch 6-7 and the sh73a4 legacy removal code by Laurent, I
think the main blocker there is the r8a73a4 CCF support patch. I don't
want to remove legacy code before reference is at least half-complete.

How can we move forward on the r8a73a4 CCF bits?

Cheers,

/ magnus
