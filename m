From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 28 Jan 2014 10:34:47 +0000
Subject: Re: [PATCH V2 2/3] ARM: shmobile: r8a7790: Add PCI USB host clock support
Message-Id: <52E787C7.7040601@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1389982854-20680-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1389982854-20680-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 28/01/14 10:29, Magnus Damm wrote:
> Hi Ben,
>
> On Tue, Jan 28, 2014 at 7:20 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> On 28/01/14 08:35, Ben Dooks wrote:
>>
>>> Yes, although I have been doing my initial testing with the RAM size
>>> limited to 1GiB of memory.
>>>
>>> I've found a couple of minor issues with the PCI bridge driver that
>>> so far have not actually fixed my problem which I hope to get reviewed
>>> and sent to the lists today.
>>>
>>> I am going to try the 'legacy' boot method today and see if I get the
>>> same problems, just to verify if the problem is with the fdt conversion
>>> or there is an issue with my board/code.
>>
>>
>> I've sent the test/fix patches to the list, and have tried building
>> with the legacy H2 code which seems to do the same thing.
>
> Ok, thanks for checking.
>
>> I cannot seem to currently build a working 3.4-ltsi release, so will
>> have to wait to see if that will work on my board or not.
>
> So I prefer to focus on moving forward upstream, but if you're
> blocking on this then feel free to ask Simon about LTSI and he can
> most likely guide you. This includes stuff in renesas-backport git
> repo but excludes the BSP bits.

Yeah, we've had some weird bit-rot issue with this. I will try a clean
checkout later. The ltsi is just really to see if our Lager board has
some issue with the USB0 channel (verify the hardware has not been
broken at some point)

I am going to leave the CH0 issue for the moment and wait until we've
cleared this release so that we can then look at rebasing on 3.14-rc1
after FOSDEM.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
