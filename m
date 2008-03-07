From: "Will Newton" <will.newton@gmail.com>
Date: Fri, 07 Mar 2008 11:54:28 +0000
Subject: Re: [BUG REPORT] smc911x: Auto negotiation NOT supported
Message-Id: <87a5b0800803070354x391ff718u3af9664804526da1@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <59fd4ce80803062200n203e5cd7o152be120adbdb717@mail.gmail.com>
In-Reply-To: <59fd4ce80803062200n203e5cd7o152be120adbdb717@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeongdo Son <sohn9086@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-SH <linux-sh@vger.kernel.org>

On Fri, Mar 7, 2008 at 6:00 AM, Jeongdo Son <sohn9086@gmail.com> wrote:

>  The problem is that only the first ifup after cold boot succeed.
>  Here is the instruction how to reproduce the symptom.
>  (smc911x is recognized as eth0 on the board.)
>  1. boot up the board, and login.
>  2. ifup eth0  (after doing this, ping works)
>  3. ifdown eth0
>  4. ifup eth0 ("Auto negotiation NOT supported" printed, and ping doesn't works)
>  Please refer to the bottom of this mail.

Are you getting interrupts from the chip? Sounds like it could be you
have missed and interrupt somewhere - check where your interrupt
polarities and where you are acking/clearing them down.
