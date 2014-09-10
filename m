From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Sep 2014 02:11:12 +0000
Subject: Re: [PATCH] ARM: shmobile: lager: Remove legacy C board code
Message-Id: <CANqRtoRRKu=ooUqMRhqduNd8ecL-NLyvM_pwb4OSLXN+8oX5mA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140904023440.26241.39089.sendpatchset@w520>
In-Reply-To: <20140904023440.26241.39089.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Sep 10, 2014 at 11:01 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Sep 10, 2014 at 09:50:31AM +0900, Magnus Damm wrote:
>> Hi Simon,
>>
>> On Wed, Sep 10, 2014 at 9:30 AM, Simon Horman <horms@verge.net.au> wrote:
>> > On Fri, Sep 05, 2014 at 12:35:49PM +0900, Magnus Damm wrote:
>> >> Hi Simon,
>> >>
>> >> On Thu, Sep 4, 2014 at 9:14 PM, Simon Horman <horms@verge.net.au> wrote:
>> >> > On Thu, Sep 04, 2014 at 08:38:02PM +0900, Magnus Damm wrote:
>> >> >> Hi Sergei,
>> >> >>
>> >> >> On Thu, Sep 4, 2014 at 8:06 PM, Sergei Shtylyov
>> >> >> <sergei.shtylyov@cogentembedded.com> wrote:
>> >> >> > Hello.
>> >> >> >
>> >> >> > On 9/4/2014 6:34 AM, Magnus Damm wrote:
>> >> >> >
>> >> >> >> From: Magnus Damm <damm+renesas@opensource.se>
>> >> >> >
>> >> >> >
>> >> >> >> The Multiplatform r8a7790 Lager board code is at this point
>> >> >> >> in equally or better state compared to the legacy code.
>> >> >> >
>> >> >> >
>> >> >> >    I think it's a bit premature to say this. For example, USBHS DT support
>> >> >> > hasn't been merged (the .dts[i] part hasn't even been posted yet IIRC).
>> >> >> > The USB PHY DT support also hasn't been merged.
>> >> >>
>> >> >> Thanks for letting us know. It may be a bit early then.
>> >> >
>> >> > At this point my feeling is that its better to wait if there are still
>> >> > features in Legacy-C that haven't made it across to multiplatform yet.
>> >>
>> >> I agree, waiting must be the best option. Thanks!
>> >
>> > A general comment about removing board code:
>> >
>> > As suggested by Arnd elsewhere, please also submit a patch to remove
>> > #ifdef CONFIG_USE_OF from the relevant setup-*.c file when you remove
>> > the legacy board code if the setup-*.c will thus always be compiled with
>> > ARCH_MULTIPLATFORM which selects CONFIG_USE_OF.
>>
>> Sure, of course. The main concern from my side was to introduce as few
>> difficulties as ever possible merge-wise. I may have misunderstood
>> things, but I thought having SoC cleanups that depend on Board
>> cleanups in the same merge window may complicate the ARM SoC merge?
>> Because of this a SoC cleanup like suggested above cannot easily
>> depend on a board cleanup like the legacy board code removal patch. So
>> my plan was to first remove the legacy board code in one merge window,
>> and in the second one cleanup the SoC bits.
>>
>> Please correct me if I'm wrong.
>
> Thanks, that sounds ideal to me.
>
> The main purpose of my previous email was to make a public note about
> something Arnd had brought to my attention.  I agree entirely that we
> should take care to oder cleanups as you describe.

Gotcha, good to hear that we're on the same page!

/ magnus
