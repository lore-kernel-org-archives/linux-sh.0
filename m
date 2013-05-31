From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 May 2013 00:33:19 +0000
Subject: Re: [PATCH 0/5] HSCIF support
Message-Id: <CANqRtoQAYiCh1eorRUUQYRahuaYJR5skXXezoirMb7yK60js0A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1369743728-26084-1-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1369743728-26084-1-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thanks for your work on this. Just a quick comment regarding testing from me:

On Tue, May 28, 2013 at 9:22 PM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
> Hi!
>
> This set implements HSCIF support for the r8a7790. Since the Lager board
> doesn't actually have these wired up -- except HSCIF1, but those pins are
> needed for the serial console -- it has not received real-world testing.

I may be misunderstanding, but I believe it should be possible to test
these HSCIF patches using the serial console port configured as HSCIF?
Or is there any reason why we can't do that?

Cheers,

/ magnus
