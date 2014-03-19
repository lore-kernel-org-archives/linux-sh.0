From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 Mar 2014 12:30:55 +0000
Subject: Re: [PATCH] ARM: shmobile: Add Lager clock workarounds for SDHI and MMCIF
Message-Id: <CANqRtoS0YNcEadDz-mVFZWdpaHTHOsXik36WixbCpLT0XH3Aow@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140318125247.21670.94176.sendpatchset@w520>
In-Reply-To: <20140318125247.21670.94176.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Mar 19, 2014 at 7:01 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> On Wednesday 19 March 2014 10:03:32 Magnus Damm wrote:
>> On Tue, Mar 18, 2014 at 10:25 PM, Laurent Pinchart wrote:
>> > On Tuesday 18 March 2014 21:52:47 Magnus Damm wrote:
>> >> From: Magnus Damm <damm@opensource.se>
>> >>
>> >> Add MMCIF1, SDHI0 and SDHI2 to the clock workaround list for
>> >> Lager multiplatform. Without these additional lines wakeup
>> >> from Suspend-to-RAM never happens.
>> >
>> > What about fixing the root cause instead of piling up hacks ?
>>
>> -ENOPATCH? =)
>>
>> Perhaps we need to learn what the root cause is before making a proper
>> patch?
>
> Sure :-) Could you elaborate a bit on what issue the patch fixes ? Is S2R
> broken completely, only with multiplatform kernels, only when runtime PM is
> enabled ? The commit message isn't very explicit about that.

Suspend-to-RAM is working fine in the legacy case. However it is not
for Multiplatform, more specifically shmobile_defconfig which includes
Runtime PM disabled. I tracked it down to SDHI on Koelsch and Lager
and also MMCIF on Lager.

> Ben mentioned that he was working on a workaround to use
> drivers/sh/pm_runtime.c as-is with multi-platform kernels. Assuming the S2R
> problem is limited to multi-platform kernels, I would prefer that workaround
> if that's fine with you as well.

Please discuss this with Geert. I'm fine with any kind of short term
solution as long as it is working.

Thanks,

/ magnus
