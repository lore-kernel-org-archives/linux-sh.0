From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 07 Oct 2014 03:25:34 +0000
Subject: Re: [PATCH] ARM: shmobile: Handle CA7 arch timer delay
Message-Id: <CANqRtoQQ-CCuPSzrTeYt4+ChmYRC5z3jUTFEHr86F86-ZLMMEQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141005235920.3532.40364.sendpatchset@w520>
In-Reply-To: <20141005235920.3532.40364.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Tue, Oct 7, 2014 at 8:59 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Oct 06, 2014 at 08:59:20AM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Update the delay code to include arch timer checks
>> for CA7. From a arch timer availability perspective
>> CA7 should be treated same as CA15.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>>
>>  Written against renesas-devel-20141002-v3.17-rc7
>
> Thanks Magnus, I have queued this up.
>
> There is an outstanding question from Arnd
> relating to the last round of init delay updates.
> If you have a moment could you look into it?
>
> * Re: [GIT PULL] Renesas ARM Based SoC Init Delay Updates For v3.18
>   http://www.spinics.net/lists/arm-kernel/msg360580.html

Thanks, I will. It's been on my TODO for quite some time now!

Cheers,

/ magnus
