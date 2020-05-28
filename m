From: Rob Landley <rob@landley.net>
Date: Thu, 28 May 2020 09:40:28 +0000
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-Id: <3a2164e3-08da-efea-2d58-5e230a85ccce@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org> <20200528054600.GA29717@infradead.org>
 <67759544-b041-74af-fe95-50fca4a9ea39@physik.fu-berlin.de>
In-Reply-To: <67759544-b041-74af-fe95-50fca4a9ea39@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org, ysato@users.sourceforge.jp, dalias@libc.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>

On 5/28/20 12:55 AM, John Paul Adrian Glaubitz wrote:
> On 5/28/20 7:46 AM, Christoph Hellwig wrote:
>> [adding Linus]
>>
>> On Thu, May 07, 2020 at 07:35:52AM -0700, Christoph Hellwig wrote:
>>> Any progress on this?  I plan to resend the sh dma-mapping I've been
>>> trying to get upstream for a year again, and they would conflict,
>>> so I could look into rebasing them first.
>>
>> So for years now it has been close to and in the end impossible to
>> provoke sh maintainer action.  At the same point hardware is pretty much
>> long gone for the real commercial variants, and never took off for the
>> open hardware nommu variant.
>>
>> Linus, would you ok with a 5.8 pull request to just kill off arch/sh/?
> 
> We're maintaining SH in Debian so I'm interested in keeping arch/sh, but
> I'm also let down that SH maintainers aren't that active at the moment.
> 
> I do know that Yoshinori Sato has a tree where he takes patches and sends
> PRs from time to time, but I have no idea what is going on.

There are still people who care about the architecture and try to get fixes in:

  https://www.spinics.net/lists/linux-sh/msg56844.html

Alas, I haven't had better luck getting Rich's attention, and I say that as
someone who has his phone number.

It met Sato-san for lunch once years ago, but he lives in Tokyo and english is
not his first language. I was under the impression he became co-maintainer to
show Rich the ropes of maintainership and to answer obscure architectural
questions, not because he was volunteering for significantly more work. Rich was
supposed to be load bearing.

I don't really have the domain expertise to do it myself... :(

Rob
