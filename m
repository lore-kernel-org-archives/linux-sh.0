From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 04 Mar 2013 14:28:39 +0000
Subject: Re: SDHI and MMCIF with kzm9g-reference
Message-Id: <CANqRtoQxCKkp_+-WXHfPoeX6Ya+-wfEO+B2F52bffE+oc7gADw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130301110802.GB24364@verge.net.au>
In-Reply-To: <20130301110802.GB24364@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 4, 2013 at 10:40 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Mon, 4 Mar 2013, Simon Horman wrote:
>> On Mon, Mar 04, 2013 at 09:55:56PM +0900, Magnus Damm wrote:
>> > On Fri, Mar 1, 2013 at 9:28 PM, Simon Horman <horms@verge.net.au> wrote:
>> > > The reason that the code is like it is and not the way it would be
>> > > with the patch below (errors aside), is because Magnus specifically
>> > > asked for no early devices or early timers.
>> >
>> > Thanks for making sure that we're not enabling early timers when it is
>> > unclear if we really need to.
>>
>> Thanks for reviewing the situation.
>>
>> > Would it be possible for you to check if the timer drivers (CMT, TMU)
>> > get probe():d before the MMC drivers?
>>
>> My analysis is that the clock sources are probed after MMCIF and SDHI.
>
> Related to this: the problem with TWD on kzm9g with DT was, that CMT was
> initialised too late too. The TWD driver should be initialised before the
> secondary CPU is brought up. It is performing a calibration, and if CMT
> isn't initialised by then, the calibration never ends... So, my "local
> hack" to just enable TWD on kzm9g-reference to test CPUFreq interaction
> was to use early timers too.

Uhm, if shmobile_setup_delay() is used then the delay calculation will
be bypassed. Not sure which state the code was in when you tried
though.

So the shmobile_setup_delay() function should work for both boot and
secondary cpus. Keep in mind that configurations with both local
timers (TWD) and broad cast timer needs to work.

Thanks,

/ magnus
