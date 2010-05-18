From: Alexandre Courbot <alex@dcl.info.waseda.ac.jp>
Date: Tue, 18 May 2010 07:43:06 +0000
Subject: Re: Master not compiling for r2dplus target
Message-Id: <AANLkTilPD8M0v8qF6a_pZduKs4nXVDbYMHunhdcN7OA6@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Note that removing the culprit line results in a working kernel - on
the other hand, declaring it beforehand I just get an unresolved
symbol at link.

On Tue, May 18, 2010 at 4:37 PM, Alexandre Courbot
<alex@dcl.info.waseda.ac.jp> wrote:
>
> Hi everybody,
> Trying to compile from arch/sh/configs/rts7751r2dplus_defconfig upon a fresh update today:
> arch/sh/mm/init.c: In function 'early_reserve_mem':
> arch/sh/mm/init.c:293: error: implicit declaration of function 'reserve_crashkernel'
> The commit that introduced this issue seems to be 4bc277 on Tue May 11 13:32:19 2010 +0900.
> I'm wondering if this is the only architecture suffering from this?
> Alex.
