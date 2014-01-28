From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Jan 2014 00:28:33 +0000
Subject: Re: [PATCH V2 2/3] ARM: shmobile: r8a7790: Add PCI USB host clock support
Message-Id: <CANqRtoQKq-kaouduUmop+M8FYgpXstmg46Sqk07fGrGmRanNBQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389982854-20680-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1389982854-20680-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 24, 2014 at 8:37 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> On 24/01/14 04:47, Magnus Damm wrote:
>>
>> On Sat, Jan 18, 2014 at 3:20 AM, Valentine Barshak
>> <valentine.barshak@cogentembedded.com> wrote:
>>>
>>> This adds internal PCI USB host clock support.
>>>
>>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>>> ---
>>>   arch/arm/mach-shmobile/clock-r8a7790.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> Changes in V2:
>>> * capitalized ARM in the subject;
>>> * rebased on top the latest devel tag.
>>
>>
>> This patch for PCI USB clock support seems fine to me.
>>
>> Acked-by: Magnus Damm <damm@opensource.se>
>>
>> It is common practice that maintainers reject code to encourage people
>> to do further development. I don't think that will help us in this
>> particular case, so I think it is best to merge this as-is but also
>> request you to spend your future time on DT development.
>>
>> So please work on DT reference support together with CCF for PCI USB.
>
>
> I've already posted a series for getting this device treeed.

Thanks for that!

> As a note, does channel 0 work for you? we are getting a lot of
> failures with the OHCI controller failing to start with what looks
> like a bus-master failure.

I've only used USB0 as USBHS, and due to lack of cable detection
hardware support on Lager (and me missing the cable needed for host) I
plan on simply fixing USB0 as USBHS Function. Anyone wanting to test
USB PCI Host should in my opinion use USB1 on Lager. USB2 is also fine
until USB 3.0 support is tied in there.

As both you and I have noted, the USB PCI stuff can't work well as-is
due to mismatch in physical address space between the PCI hardware and
the actual memory on Lager. So as we discussed, bounce buffers would
be needed and perhaps also IOMMU support but my feeling is that may as
well be for later in case of USB.

So until I see USB PCI bounce buffer support or similar I will simply
assume all errors on USB PCI on r8a7790 and r8a7791 are related to
physical address size mismatch and lacking software support. Do you
have anything that points in a different direction?

Does USB1 and/or USB2 work for you as-is today?

Thanks,

/ magnus
