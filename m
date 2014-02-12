From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Feb 2014 08:51:46 +0000
Subject: Re: [PATCH v2 01/02] ARM: shmobile: Add SDHI devices to r8a7791 DTSI
Message-Id: <CANqRtoQ8uYZcMQC5EQ6DLHGb3noOFsnTvtFTvPaMQarOdkD5Aw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140212074119.23493.28243.sendpatchset@w520>
In-Reply-To: <20140212074119.23493.28243.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 12, 2014 at 5:48 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Feb 12, 2014 at 9:37 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> On Wed, Feb 12, 2014 at 8:41 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>>> Changes since V1:
>>>>  - add r8a7790 suffix as fall back in case r8a7791 is missing from the driver
>>>
>>> I'm afraid that's not such a good idea: what if r8a7791 SDHI turns out to have a
>>> slight incompatibility with r8a7790 SDHI later?
>>
>> It's a fallback so later we will simply use r8a7791 instead. r8a7790
>> is currently used with the v3.14-rc version of the SDHI driver. Future
>> ones always include r8a7791. How does that introduce any issues?
>
> Bummer, yes, it prefers the first compatible entry.
>
> Will refrain from sending more emails until my coffee has been digested ;-)

Heheh. But I think you raise a valid point:

Using the wrong SoC in the compatible string is pretty darn ugly.

What is the best practise here?

/ magnus
