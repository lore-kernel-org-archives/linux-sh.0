From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 14 Oct 2015 08:36:56 +0000
Subject: Re: [PATCH] ARM: shmobile: defconfig: enable HDMI output for RCar
Message-Id: <CANqRtoR0HPu2gjeBqUcOV4jBODSAkZoECXV=Dt+7++sgZVawEQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1407974835-11064-1-git-send-email-khilman@linaro.org>
In-Reply-To: <1407974835-11064-1-git-send-email-khilman@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Wed, Oct 14, 2015 at 5:22 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Wed, Oct 14, 2015 at 10:09 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> Or do you mean disabling them upfront?
>>> There are some clocks that must not be disabled. Some of them are not
>>> documented.
>>
>> Disabling them upfront with sparse documentation seems fun, but also a
>> bit like asking for trouble. =)
>
> I have hackish code that does it for all boards I have, and use it actively.

Seems like a good feature to me!

>> So disabling clocks upfront may be a troublesome but good way to
>> trigger incorrect dependencies, and unless I'm mistaken it should give
>> the same behaviour as the updated u-boot version, right?
>
> More or less (U-Boot still keeps a few enabled for its own use, e.g. Ethernet).

So it fails to cleanup after itself then... But by disabling clocks
upfront I guess you can be even more aggressive.

Anyway, it would be nice to see that feature upstream at some point.
Let me know if there is anything I can do to help!!

Cheers,

/ magnus
