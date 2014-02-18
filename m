From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 18 Feb 2014 03:42:53 +0000
Subject: Re: [PATCH V3 0/3] ARM: shmobile: lager: Add USB support
Message-Id: <CANqRtoScch-Ji3oJjTJELnG5_fKeiQcrzmO2ZtMSW=S40aGyxg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390602529-11867-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1390602529-11867-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 5, 2014 at 6:31 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> On 28/01/14 21:37, Valentine wrote:
>>
>> On 01/27/2014 04:17 PM, Ben Dooks wrote:
>>>
>>> On 27/01/14 10:02, Valentine wrote:
>>>>
>>>> On 01/27/2014 01:59 PM, Ben Dooks wrote:
>>>>>
>>>>> On 24/01/14
>>>
>>>
>>> [snip]
>>>
>>>>> Hi, when doing this have you come across a problem where the OHCI
>>>>> controller on USB0 fails to start with an initialisation error? I
>>>>> think it is something to do with the bridge setup but have yet to
>>>>> have enough time to look into this issue.
>>>>>
>>>>
>>>> All PCI ports have worked fine for me.
>>>> Please, check that the SW5/SW6 pins are set correctly on your board.
>>>
>>>
>>> SW5 is at position 1
>>> SW6 is at position 1
>>>
>>
>> If the issue doesn't happen on other busses this is most likely
>> port misconfiguration issue. Looks like the USB phy channel 0 is not
>> configured properly.
>> Please, make sure that you have all the patches
>> noted in the cover-letter applied and that you're using the latest
>> devel tag from the renesas git.
>
>
> I tracked it down to the phy driver being called after the ohci/ehci
> drivers being initialised. It now seems to be working with all three
> channels.

Thanks for sharing. I too managed to get USB1 and USB2 on lager going
as expected.

Cheers,

/ magnus
