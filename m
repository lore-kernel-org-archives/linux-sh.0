From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 10 Aug 2020 13:06:56 +0000
Subject: Re: Pull Request for 5.9
Message-Id: <937d5c16-f9bc-1bee-5f67-18746b3eddb5@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <16a9b527-e05c-dcac-86bd-b79be140c053@physik.fu-berlin.de>
In-Reply-To: <16a9b527-e05c-dcac-86bd-b79be140c053@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rich!

On 8/7/20 8:35 PM, John Paul Adrian Glaubitz wrote:
> On 8/7/20 8:34 PM, Rich Felker wrote:
>> On Fri, Aug 07, 2020 at 09:36:07AM +0200, John Paul Adrian Glaubitz wrote:
>>> Hi Rich!
>>>
>>> Any chance you can send the pull request to Linus for 5.9?
>>>
>>> I would like to see my get_user() patch merged as otherwise libsecomp upstream
>>> won't allow me to open the PR to get the userland changes merged for SECCOMP
>>> support.
>>
>> Yep, it's on my todo for this week. I'll try to get to it today. Does
>> everything in next look good to you?
> 
> I haven't done testing on next yet, but I will do that by Sunday - at latest.

From my side, everything is fine now. Al has sent a PR to Linus fixing the
one issue I found in -next. So I think you can send out the PR now.

Then we can sort through the other patches for SH which might have not been
picked up through any of the other trees yet.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
