From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 16 May 2014 04:39:11 +0000
Subject: Re: [PATCH] ARM: shmobile: Use shmobile_init_late() on r8a7740
Message-Id: <CANqRtoSKosY3HLc-Hgbf2_ToDeL71QzqamWEd97xX9iaD=2oUQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140511231050.19908.86623.sendpatchset@w520>
 <CAMuHMdW4-r8khvk-hJcx1OXqwT0nGsVm3zEnmW6TUhyeDRPWdg@mail.gmail.com>
 <20140513081019.GA10412@verge.net.au>
 <20140516040844.GA2503@verge.net.au>
In-Reply-To: <20140516040844.GA2503@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Fri, May 16, 2014 at 1:08 PM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, May 13, 2014 at 05:10:20PM +0900, Simon Horman wrote:
>> On Mon, May 12, 2014 at 09:42:15AM +0200, Geert Uytterhoeven wrote:
>> > On Mon, May 12, 2014 at 1:10 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> > > From: Magnus Damm <damm+renesas@opensource.se>
>> > >
>> > > Hook up ->init_late for r8a7740 to initialize Suspend-to-RAM
>> > > and CPUIdle in case of C-code less board support for r8a7740.
>> > >
>> > > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> >
>> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>> Thanks, I will queue this up.
>
> Hi Magnus, Hi Geert,
>
> As I am currently doing some work for the r8a7779
> I am wondering if a change like this one is appropriate for that SoC.
> If so I'll cook one up.

Yes, we want all SoCs to be converted over. Please take care that some
DTS change may be needed to specify maximum frequency, so this may
require a DTB update for the user. Which makes it less nice user
experience for legacy code - if we care about that at this point. But
legacy code also often tends to use early devices and other stuff, so
this probably affects DT SoC code and DT reference board code mostly.

Cheers,

/ magnus
