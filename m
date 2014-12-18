From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 18 Dec 2014 01:33:22 +0000
Subject: Re: [PATCH v2 0/7] ARM: shmobile: ape6evm: multiplatform support
Message-Id: <CANqRtoRr0qOd4KVG2D07hou7piB+JR4SfFQEtVh2Fb-t7qvNOA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418747163-21729-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1418747163-21729-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Thu, Dec 18, 2014 at 10:25 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Dec 18, 2014 at 10:22:00AM +0900, Magnus Damm wrote:
>> Hi Simon,
>>
>> On Thu, Dec 18, 2014 at 9:19 AM, Simon Horman <horms@verge.net.au> wrote:
>> > On Wed, Dec 17, 2014 at 05:20:15PM +0100, Ulrich Hecht wrote:
>> >> On Wed, Dec 17, 2014 at 2:23 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> >> > Hi Ulrich and Simon,
>> >> >
>> >> > On Wed, Dec 17, 2014 at 1:25 AM, Ulrich Hecht
>> >> > <ulrich.hecht+renesas@gmail.com> wrote:
>> >> >> It is split in such a way that the first five patches can be merged without
>> >> >> breaking either of the two legacy platforms.  Simon, please pick those up.
>> >> >> (Or the first three, if adding a multiplatform target that does not build is
>> >> >> a problem.) Thank you.
>> >> >
>> >> > The first patch seems to have some issue reported by Laurent. It needs
>> >> > to be reworked.
>> >> >
>> >> > Patch 2-5 should be possible to merge as-is unless I'm mistaken.
>> >> >
>> >> > Simon, if you don't mind, can you please consider picking up 2-5 before 1, 6-7?
>> >>
>> >> I respun the series following Laurent's suggestions, there should be
>> >> no need for special-casing anymore.
>> >>
>> >> > As for patch 6-7 and the sh73a4 legacy removal code by Laurent, I
>> >> > think the main blocker there is the r8a73a4 CCF support patch. I don't
>> >> > want to remove legacy code before reference is at least half-complete.
>> >> >
>> >> > How can we move forward on the r8a73a4 CCF bits?
>> >>
>> >> For starters I have sent a new version of the series with the last
>> >> remaining trivialities fixed.
>> >
>> > Thanks, that seems clean to me. And I see that Laurent has Acked the
>> > changes. I will queue those up.
>>
>> Thanks. I assume you guys work out the CCF vs the shmobile ordering
>> and keep at least one DT-reference implementation working at any given
>> time.
>
> Yes, that is the assumption that I am working on.

Great, thank you!

/ magnus
