From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Fri, 31 May 2013 15:28:02 +0000
Subject: Re: [PATCH 0/5] HSCIF support
Message-Id: <CAO3366yMwF5JKad0N4HuYiXLX7HZyhsGC81KxiBJd+rJ9kntPg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1369743728-26084-1-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1369743728-26084-1-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 31, 2013 at 2:33 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Tue, May 28, 2013 at 9:22 PM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
>> This set implements HSCIF support for the r8a7790. Since the Lager board
>> doesn't actually have these wired up -- except HSCIF1, but those pins are
>> needed for the serial console -- it has not received real-world testing.
>
> I may be misunderstanding, but I believe it should be possible to test
> these HSCIF patches using the serial console port configured as HSCIF?
> Or is there any reason why we can't do that?

No, not really. I must have filed that under "dead end" when I tried
it earlier and it didn't work (because of the missing BRG clock, but I
didn't know that at the time).

Anyway, I tried it and it officially works now.

CU
Uli
