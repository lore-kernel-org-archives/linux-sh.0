From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 23 Apr 2014 02:07:25 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: Koelsch DT serial integration prototype
Message-Id: <CANqRtoQOfWHS5FD6pvDTy23ictoOriJ2ht8r5zPKrUCZnHtdYw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140421013114.3236.90868.sendpatchset@w520>
In-Reply-To: <20140421013114.3236.90868.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Mon, Apr 21, 2014 at 6:50 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patch.
>
> On Monday 21 April 2014 10:31:14 Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> A simple serial port integration prototype that happens to
>> target Koelsch. Written to propose how to move one step closer
>> to integrate DT support for serial ports on mach-shmobile.
>
> I think you've over-engineering it. I would just switch serial devices to DT
> in one go, like we do for all other devices.

I agree about the risk of over-engineering! =)

At the same time I would like to integrate your serial DT support as
soon as possible. Order wise I'd like to integrate your serial DT
support before phasing out legacy board code. We can of course discuss
the order, but if we first integrate serial DT then we end up with 3
different serial cases since legacy does not use DT for "regular
devices" at all. This seems quite messy in my mind, so with this
proposal I hope to let all us upstream developers focus on the
"DT-only board code" case that should move forward unrestricted, and
at the same time keep the C board code as-is serial port wise but also
start phasing out more aggressively.

I'm also considering handling timers the same. The point is to allow
unrestricted development of "DT-only board code" and still limit the
amount of churn for legacy to a bare minimum.

Let us discuss more face to face at ELC!

Thanks,

/ magnus
