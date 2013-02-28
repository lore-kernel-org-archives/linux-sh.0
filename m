From: Bastian Hecht <hechtb@gmail.com>
Date: Thu, 28 Feb 2013 16:52:29 +0000
Subject: Re: [PATCH] ARM: shmobile: Armadillo800EVA-reference: Remove usage of shmobile_timer
Message-Id: <CABYn4swxphSg4Fw9JAs6Ay-sqEbAvdGcMAdHqvbj+y+xf-tPQg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1361223490-20106-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1361223490-20106-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

2013/2/28 Simon Horman <horms@verge.net.au>:
> On Wed, Feb 27, 2013 at 10:32:17AM -0600, Bastian Hecht wrote:
>> Hi Simon,
>>
>> 2013/2/22 Simon Horman <horms@verge.net.au>:
>> > On Tue, Feb 19, 2013 at 09:05:16AM -0600, Bastian Hecht wrote:
>> >> Hi Simon,
>> >>
>> >> 2013/2/18 Simon Horman <horms@verge.net.au>:
>> >> > On Mon, Feb 18, 2013 at 03:38:10PM -0600, Bastian Hecht wrote:
>> >> >> The struct sys_timer is gone since the patch "ARM: delete struct
>> >> >> sys_timer". Since then we can't use shmobile_timer any longer. Setting
>> >> >> .init_time directly to eva_earlytimer_init fixes the resulting compile
>> >> >> error and makes the code shorter as well.
>> >> >
>> >> > Hi Bastian,
>> >> >
>> >> > Magnus seems to be very keen on the idea that -reference code
>> >> > shouldn't use early timer or early devices if possible.
>> >> >
>> >> > Is it possible to re-work this patch so that armadillo800eva-reference
>> >> > doesn't use early timer?
>> >>
>> >> Hmm I wonder if this is just a naming convention here. If I rename
>> >> eva_earlytimer_init() to eva_timer_init() the only thing that might
>> >> disturb us is that we call shmobile_EARLYtimer_init() inside it. But
>> >> this function only sets a callback named LATE_time_init. So we don't
>> >> break any timings.
>> >>
>> >> So are you ok if I rename eva_earlytimer_init() to eva_timer_init()?
>> >
>> > Perhaps I am missing something.
>> >
>> > In eva_earlytimer_init() I see a call to shmobile_earlytimer_init()
>> > amongst other things. And this seems to be the kind of early timer
>> > initialisation that Magnus has asked -reference code not to use.
>> >
>> > If you look at the setup code in setup-emev2.c and in particular
>> > the use and contents emev2_init_delay() then you can see the kind of setup
>> > that Magnus is advocating.
>> >
>> > This is also reflected in "[PATCH v2 0/8] ARM: shmobile: kzm9g reference
>> > SMP and cleanup". In particular:
>> >
>> > * [PATCH v2 5/8] ARM: shmobile: sh73a0: Do not use early devices with DT reference
>> > * [PATCH v2 6/8] ARM: shmobile: kzm9g: Do not use early devices
>>
>> Thanks for guidance to these patches! On which branch does this
>> patchset apply? Or are they even already applied on some publicly
>> available branch?
>
> These changes should be present in both next and topic/all+next.

Yeah git remote update is my friend... thanks!

Ok I've prepared the patches. I think it would make sense to split it
into 2 parts and keep the first patch as it is and have a separate one
for removing all the early device stuff. I've prepared it in an
identical way as you cleaned up the code.
If you prefer 1 patch just tell me. Same if you want me to rebase
these patches on some specific branch.

Cheers,

 Bastian
