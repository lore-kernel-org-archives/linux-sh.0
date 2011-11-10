From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 10 Nov 2011 02:14:42 +0000
Subject: Re: [PATCH v2] ARM: mach-shmobile: sh7372 A4R suspend/resume order fix
Message-Id: <CANqRtoTrNGmKnnSnnsTpmUQotoUn7Kx19jJ=Gip7bvadn+jwvA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1111091914120.4188@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1111091914120.4188@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 10, 2011 at 8:30 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, November 09, 2011, Guennadi Liakhovetski wrote:
>> Update the sh7372 A4R code to make sure the suspend
>> callback gets to be called before the resume callback.
>>
>> Without this fix the A4R resume callback is called before
>> suspend. The resume callback restores the INTCS hardware
>> registers with incorrect data which results in interrupts
>> being masked when they shouldn't be. The user will notice
>> this issue as IIC0 timing out during boot.
>>
>> Thanks to Magnus Damm for tracking this problem down and providing the
>> initial fix and the commit description text.
>>
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> ---
>>
>> I took the liberty to reimplement the original fix by Magnus in a
>> different way. I didn't quite like the idea of rewriting platform data,
>> which could and, probably, should actually be const, on each
>> domain-suspend. Instead, checking in resume, whether a valid state
>> snapshot is available seemed a bit prettier to me:-) The maintainer is, of
>> course, free to choose whichever version he prefers, they both
>>
>> "Fix issue in v3.2-rc1 on the sh7372 Mackerel board."
>
> Magnus, Paul, which one do you want me to take?

I prefer leaving the INTCS code as-is - unaware of calling order and
putting the workaround in the Runtime PM code. In the end the ordering
issue is related to Runtime PM and not INTCS. If someone knows a
better way to fix the Runtime PM code then I'd be happy to accept
that. But I don't like putting the workaround in INTCS.

Cheers,

/ magnus
